//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================

/// @func hexagon_axial_coordinate_test_conversion_to_cube
/// @desc Verify that conversion to cube coordinates works.
function hexagon_axial_coordinate_test_conversion_to_cube()
{
	//
	// Arrange
	//
	var _coordinate = new HexagonAxialCoordinate(100, 25); 

	//
	// Act
	//
	var _cube_coordinate = _coordinate.hexagon_coordinate_to_cube();

	//
	// Assert
	//
	hexagon_assert_equal( 100, _cube_coordinate.hexagon_cube_coordinate_q);
	hexagon_assert_equal(  25, _cube_coordinate.hexagon_cube_coordinate_r);
	hexagon_assert_equal(-125, _cube_coordinate.hexagon_cube_coordinate_s);
}

#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================
#endregion