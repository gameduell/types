
import types.UGridSize;

class UGridSizeTest extends haxe.unit.TestCase
{
    private function assertGridSize(_columns : Int, _rows : Int, _gridSize : UGridSize)
    {
        var failed = false;

        if (_columns != _gridSize.Columns)
        {
            failed = true;
        }

        if (_rows != _gridSize.Rows)
        {
            failed = true;
        }

        if(failed == true)
        {
            trace("Comparison Failed, expected: " + "Columns: " + _columns + " Rows: " + _rows + " and got: " + _gridSize.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    public function testCreation()
    {
        var gridSize = new UGridSize();
        assertGridSize(0,0,gridSize);
    }

    public function testCreationWithValue()
    {
        var gridSize = new UGridSize(4, 5);
        assertGridSize(4,5,gridSize);
    }

    public function testSetColumns()
    {
        var gridSize = new UGridSize();
        gridSize.Columns = 50;
        assertGridSize(50, 0,gridSize);
    }

    public function testSetRows()
    {
        var gridSize = new UGridSize();
        gridSize.Rows = 100;
        assertGridSize(0, 100,gridSize);
    }

    public function testSetColumnsAndRows()
    {
        var gridSize = new UGridSize();
        gridSize.setColumnsAndRows(-80, 40);
        assertGridSize(0, 40,gridSize);
    }

    public function testSetNegativeValues()
    {
        var gridSize = new UGridSize();
        gridSize.Columns = -4000;
        gridSize.Rows = -50;
        assertGridSize(0, 0,gridSize);
    }
}