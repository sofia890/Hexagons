
//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================

/// @func HexagonAxialCoordinate
/// @desc Axial coordinate position. See https://www.redblobgames.com/grids/hexagons/ for more details.
/// @param {real} _q Q-axis position.
/// @param {real} _r R-axis position.
function HexagonAxialCoordinate(_q, _r) : HexagonCoordinate() constructor
{
	//=============================================================================================
	#region New functions =========================================================================
	//=============================================================================================
	#endregion

	//=============================================================================================
	#region Overriden functions ===================================================================
	//=============================================================================================

	/// @func hexagon_coordinate_to_cube
	/// @desc Convert to cube coordinate.
	/// @return {struct.HexagonCubeCoordinate} Cube coordinate.
	function hexagon_coordinate_to_cube()
	{
		var _s = -hexagon_axial_coordinate_q - hexagon_axial_coordinate_r;
		return new HexagonCubeCoordinate(hexagon_axial_coordinate_q, hexagon_axial_coordinate_r, _s);
	}

	/// @func hexagon_coordinate_neighbors
	/// @desc Get neighbors.
	/// @return {Array<struct.HexagonAxialCoordinate>} Surrounding coordinates.
	function hexagon_coordinate_neighbors()
	{
		var _q = hexagon_cube_coordinate_q;
		var _r = hexagon_cube_coordinate_r;

		return [new HexagonAxialCoordinate(_q + 1, _r + 0), new HexagonAxialCoordinate(_q + 1, _r - 1),
		        new HexagonAxialCoordinate(_q + 0, _r - 1), new HexagonAxialCoordinate(_q - 1, _r + 0),
				new HexagonAxialCoordinate(_q - 1, _r + 1), new HexagonAxialCoordinate(_q + 0, _r + 1)];
	}

	/// @func hexagon_coordinate_to_axial
	/// @desc Convert to axial coordinate.
	/// @return {struct.HexagonAxialCoordinate} Axial coordinate.
	function hexagon_coordinate_to_axial()
	{
		return self;
	}
	#endregion

	//=============================================================================================
	#region New variables =========================================================================
	//=============================================================================================
	hexagon_axial_coordinate_q = _q;
	hexagon_axial_coordinate_r = _r;
	#endregion

	//=============================================================================================
	#region Constructor ===========================================================================
	//=============================================================================================
	hexagon_coordinate_type = HEXAGON_COORDINATE_TYPE.AXIAL;
	#endregion
}

#endregion