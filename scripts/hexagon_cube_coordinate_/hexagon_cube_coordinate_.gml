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

/// @func HexagonCubeCoordinate
/// @desc Cube coordinate position. See https://www.redblobgames.com/grids/hexagons/ for more details.
/// @param {real} _q Q-axis position.
/// @param {real} _r R-axis position.
/// @param {real} _s S-axis position.
function HexagonCubeCoordinate(_q, _r, _s,) : HexagonCoordinate() constructor
{
	//=============================================================================================
	#region New functions =========================================================================
	//=============================================================================================

	/// @func hexagon_cube_coordinate_subtract
	/// @desc Get the resutls of subtracting <_other> from this coordinate.
	/// @param {HexagonCubeCoordinate} _other The coordinate to subtract from this one.
	/// @return {HexagonCubeCoordinate} The result of subtracting another coordinate from this one.
	function hexagon_cube_coordinate_subtract(_other)
	{
		var _new_q = hexagon_cube_coordinate_q - _other.hexagon_cube_coordinate_q;
		var _new_r = hexagon_cube_coordinate_r - _other.hexagon_cube_coordinate_r;
		var _new_s = hexagon_cube_coordinate_s - _other.hexagon_cube_coordinate_s;

		return new HexagonCubeCoordinate(_new_q, _new_r, _new_s);
	}
	#endregion

	//=============================================================================================
	#region Overriden functions ===================================================================
	//=============================================================================================

	/// @func hexagon_coordinate_neighbors
	/// @desc Get neighbors.
	/// @return {Array<struct.HexagonCubeCoordinate>} Surrounding coordinates.
	function hexagon_coordinate_neighbors()
	{
		var _q = hexagon_cube_coordinate_q;
		var _r = hexagon_cube_coordinate_r;
		var _s = hexagon_cube_coordinate_s;

		return [new HexagonCubeCoordinate(_q + 1, _r + 0, _s - 1), new HexagonCubeCoordinate(_q + 1, _r - 1, _s +  0),
		        new HexagonCubeCoordinate(_q + 0, _r - 1, _s + 1), new HexagonCubeCoordinate(_q - 1, _r + 0, _s + 1),
				new HexagonCubeCoordinate(_q - 1, _r + 1, _s + 0), new HexagonCubeCoordinate(_q + 0, _r + 1, _s - 1)];
	}

	/// @func hexagon_coordinate_to_axial
	/// @desc Convert to axial coordinate.
	/// @return {struct.HexagonAxialCoordinate} Axial coordinate.
	function hexagon_coordinate_to_axial()
	{
		return new HexagonAxialCoordinate(hexagon_cube_coordinate_q, hexagon_cube_coordinate_r);
	}

	/// @func hexagon_coordinate_to_cube
	/// @desc Convert to cube coordinate.
	/// @return {struct.HexagonCubeCoordinate} Axial coordinate.
	function hexagon_coordinate_to_cube()
	{
		return self;
	}
	#endregion

	//=============================================================================================
	#region New variables =========================================================================
	//=============================================================================================
	hexagon_cube_coordinate_q = _q;
	hexagon_cube_coordinate_s = _s;
	hexagon_cube_coordinate_r = _r;
	#endregion

	//=============================================================================================
	#region Constructor ===========================================================================
	//=============================================================================================
	hexagon_coordinate_type = HEXAGON_COORDINATE_TYPE.CUBE;
	#endregion
}

#endregion