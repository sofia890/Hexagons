//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
enum HEXAGON_DIRECTION
{
	R,
	Q_R,
	Q,
	Q_S,
	S,
	S_R,
	SIZE
}
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================

/// @func HexagonCoordinate
/// @desc Base coordinate struct.
function HexagonCoordinate() constructor
{
	//=============================================================================================
	#region New functions =========================================================================
	//=============================================================================================

	/// @func hexagon_coordinate_neighbors
	/// @desc Get neighbors.
	/// @param {enum.HEXAGON_DIRECTION} _direction Cube coordinate equvivalent direction.
	/// @return {struct.HexagonCoordinate} Surrounding coordinates.
	function hexagon_coordinate_neighbor(_direction)
	{
		return hexagon_coordinate_neighbors()[_direction];
	}

	/// @func hexagon_coordinate_equals
	/// @desc Compare two coordinates.
	/// @param {struct.HexagonCoordinate} _other The coordinate to compare with.
	/// @return {bool} True if the 2 struct are a match.
	function hexagon_coordinate_equals(_other)
	{
		var _cube_a = hexagon_coordinate_to_cube();
		var _cube_b = _other.hexagon_coordinate_to_cube();

		// Implement in inheriting structs.
		return _cube_a.hexagon_cube_coordinate_q == _cube_b.hexagon_cube_coordinate_q &&
		       _cube_a.hexagon_cube_coordinate_r == _cube_b.hexagon_cube_coordinate_r &&
			   _cube_a.hexagon_cube_coordinate_s == _cube_b.hexagon_cube_coordinate_s;
	}

	/// @func hexagon_coordinate_neighbors
	/// @desc Get neighbors.
	/// @return {Array<struct.HexagonCoordinate>} Surrounding coordinates.
	function hexagon_coordinate_neighbors()
	{
		// Implement in inheriting structs.
		return [new HexagonCoordinate()];
	}

	/// @func hexagon_coordinate_to_cube
	/// @desc Convert to cube coordinate.
	/// @return {struct.HexagonCubeCoordinate} Cube coordinate.
	function hexagon_coordinate_to_cube()
	{
		// Implement in inheriting structs.
		return new HexagonCubeCoordinate(0, 0, 0);
	}

	/// @func hexagon_coordinate_to_axial
	/// @desc Convert to axial coordinate.
	/// @return {struct.HexagonAxialCoordinate} Axial coordinate.
	function hexagon_coordinate_to_axial()
	{
		// Implement in inheriting structs.
		return new HexagonAxialCoordinate(0, 0);
	}

	/// @func hexagon_coordinate_distance
	/// @desc Get the distance between this and another cooridnate.
	/// @param {struct.HexagonCoordinate} _other The end coordinate.
	/// @return {real} Distance.
	function hexagon_coordinate_distance(_other)
	{
		var _cube_a = hexagon_coordinate_to_cube();
		var _cube_b = _other.hexagon_coordinate_to_cube();
		var _vector = _cube_a.hexagon_cube_coordinate_subtract(_cube_b);

		var _cummulative_diff = abs(_vector.hexagon_cube_coordinate_q) +
					            abs(_vector.hexagon_cube_coordinate_r) +
							    abs(_vector.hexagon_cube_coordinate_s);

		return _cummulative_diff / 2;
	}

	/// @func hexagon_coordinate_to_string
	/// @desc Represent the coordinate as a string. 
	/// @return {string} Text representation.
	function hexagon_coordinate_to_string()
	{
		var _cube_coordinate = hexagon_coordinate_to_cube();

		return string("{0}, {1}, {2}",
		              _cube_coordinate.hexagon_cube_coordinate_q,
					  _cube_coordinate.hexagon_cube_coordinate_r,
					  _cube_coordinate.hexagon_cube_coordinate_s);
	}
	#endregion

	//=============================================================================================
	#region Overriden functions ===================================================================
	//=============================================================================================
	#endregion

	//=============================================================================================
	#region New variables =========================================================================
	//=============================================================================================
	hexagon_coordinate_type = HEXAGON_COORDINATE_TYPE.UNKNOWN;
	#endregion

	//=============================================================================================
	#region Constructor ===========================================================================
	//=============================================================================================
	#endregion
}

#endregion