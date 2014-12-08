/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 05/06/14
 * Time: 15:44
 */
package types;

import msignal.Signal;

interface OutputStream
{
    public var onError(default, null): Signal1<OutputStream>;
    public var onOpen(default, null): Signal1<OutputStream>;
    public var onClose(default, null): Signal1<OutputStream>;

    public var errorCode(default, null): Null<Int>;
    public var errorMessage(default, null): String;

    /// CONTROL METHODS
    public function open(): Void;
    public function close(): Void;
    public function isOpen(): Bool;

    /// WRITING METHODS
    public var onDataWriteFinished(default, null): Signal2<InputStream, Data>;
    public function writeData(data : Data) : Void;

    public function isAsync(): Bool;
}