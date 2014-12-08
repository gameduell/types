/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 05/06/14
 * Time: 15:43
 */
package types;

import msignal.Signal;

interface InputStream
{
    /// If the stream's bytes available is not changed behind the scenes
    /// then they do not have to call this signal
    public var onDataAvailable(default, null): Signal1<InputStream>;

    /// not necessarily the full extent of the stream
    public var bytesAvailable(get, null): Int;

    /// STATE
    /// if it starts on end of stream, this is never called
    public var onEndOfStream(default, null): Signal1<InputStream>;
    
    public var onOpen(default, null): Signal1<InputStream>;
    public var onClose(default, null): Signal1<InputStream>;
    /// is true if the bytes available is the total ammount left on the stream
    public function isOnEndOfStream(): Bool;

    /// CONTROL METHODS
    public function open(): Void;
    public function close(): Void;
    public function isOpen(): Bool;

    public function skip(byteCount: Int): Void;

    /// READING METHOD
    /// if async, it will reply on "onReadData"
    public function readIntoData(data: Data): Void;
    public var onReadData(default, null): Signal2<InputStream, Data>;

    /// if async, all read operations will return immediately
    /// can be different per stream subclass, and even within platforms on the same stream class
    public function isAsync(): Bool;

    /// ERROR
    public var errorCode(default, null): Null<Int>;
    public var errorMessage(default, null): String;
    public var onError(default, null): Signal1<InputStream>;
}