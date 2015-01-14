/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 17:10
 */
package types;

import types.DataType.DataTypeUtils;
import types.OutputStream;

using types.DataStringTools;

import msignal.Signal;

class DataOutputStream implements OutputStream
{
    public var onError(default, null): Signal1<OutputStream>;
    public var onOpen(default, null): Signal1<OutputStream>;
    public var onClose(default, null): Signal1<OutputStream>;

    public var errorCode(default, null): Null<Int>;
    public var errorMessage(default, null): String;

    private var openned: Bool;
    private var data : Data;
    private var currentOffset : Int;
    private var currentOffsetLength : Int;
    private var resize : Bool;

    public function new(newData : Data, resize : Bool = false) : Void
    {
        onDataWriteFinished = new Signal2();
        onError = new Signal1();
        onOpen = new Signal1();
        onClose = new Signal1();

        reset(newData, resize);
    }

    public function reset(newData : Data, resize : Bool = false): Void
    {
        if (isOpen())
        {
            close();
        }

        openned = false;
        this.resize = resize;
        data = newData;
        currentOffset = data.offset;
        currentOffsetLength = 0;
    }

    /// CONTROL METHODS
    public function open(): Void
    {
        openned = true;
        onOpen.dispatch(this);
    }
    
    public function close(): Void
    {
        openned = false;
        data = null;
        onClose.dispatch(this);
    }

    public function isOpen(): Bool
    {
        return openned;
    }

    /// WRITING METHODS
    public var onDataWriteFinished(default, null): Signal2<InputStream, Data>;
    public function writeData(sourceData : Data) : Void
    {
        if (resize)
        {
            var size: Int = (currentOffset + sourceData.offsetLength) - data.allocedLength;
            if (size > 0)
            {
                grow(data.allocedLength + size);
            }
        }

        var prevOffset = data.offset;
        data.offset = currentOffset;
        data.writeData(sourceData);
        currentOffset += sourceData.offsetLength;
        data.offset = prevOffset;
        data.offsetLength += sourceData.offsetLength;
    }

    /// always grows by 1.5
    private function grow(minCapacity: Int)
    {
        var oldCapacity = data.allocedLength;
        var newCapacity = oldCapacity + (oldCapacity >> 1);
        if (newCapacity - minCapacity < 0)
            newCapacity = minCapacity;

        // minCapacity is usually close to size, so this is a win:
        data.resize(minCapacity);
    }

    public function isAsync(): Bool
    {
        return false;
    }

}