/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 14/03/14
 * Time: 11:38
 */
package types;

/// U stands for Unsigned
class UGridSize
{
    public var Rows (get,set) : Int;
    public var Columns (get,set) : Int;

    private var rows : Int;
    private var columns : Int;

    public function new(_columns : Int = 0, _rows : Int = 0) : Void
    {
        setColumnsAndRows(_columns, _rows);
    }

    public inline function setColumnsAndRows(_columns : Int, _rows : Int) : Void
    {
        set_Columns(_columns);
        set_Rows(_rows);
    }

    private inline function set_Columns(_columns : Int) : Int
    {
        if (_columns < 0)
        {
            columns = 0;
        }
        else
        {
            columns = _columns;
        }

        return columns;
    }

    private inline function set_Rows(_rows : Int) : Int
    {
        if (_rows < 0)
        {
            rows = 0;
        }
        else
        {
            rows = _rows;
        }

        return rows;
    }

    private inline function get_Columns() : Int
    {
        return columns;
    }

    private inline function get_Rows() : Int
    {
        return rows;
    }

    public function toString() : String
    {
        return "Columns: " +  columns + " Rows: " + rows;
    }
}