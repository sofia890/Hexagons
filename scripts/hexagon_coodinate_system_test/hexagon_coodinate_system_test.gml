//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================

/// @func hexagon_coodinate_system_test_check_hexagon_dimensions_flat_top
/// @desc Verify that dimensions for hexagons in a system are correct.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_check_hexagon_dimensions_flat_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 100, 0, 0); 

	//
	// Act
	//
	

	//
	// Assert
	//
	hexagon_assert_equal(200,           _system.hexagon_get_hexagon_width());
	hexagon_assert_equal(173.205080757, _system.hexagon_get_hexagon_height());
}

/// @func hexagon_coodinate_system_test_check_hexagon_dimensions_pointy_top
/// @desc Verify that dimensions for hexagons in a system are correct.
///       For a pointy topped hexagon coordinate system.
function hexagon_coodinate_system_test_check_hexagon_dimensions_pointy_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.POINTY_TOP, 100, 0, 0); 

	//
	// Act
	//
	

	//
	// Assert
	//
	hexagon_assert_equal(173.205080757, _system.hexagon_get_hexagon_width());
	hexagon_assert_equal(200,           _system.hexagon_get_hexagon_height());
}

/// @func hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached_no_obstacles
/// @desc Verify which tiles that are considred as reachable when there are no obstacles.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached_no_obstacles()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 100, 0, 0); 

	var _check_function = function(_hexagon)
	{
		return true;
	}

	var _expected_fringes = [
		[new HexagonCubeCoordinate( 0,  0,  0)],
		[new HexagonCubeCoordinate(+1, -1,  0), new HexagonCubeCoordinate(+1 , 0, -1),
		 new HexagonCubeCoordinate( 0, +1, -1), new HexagonCubeCoordinate(-1, +1,  0),
		 new HexagonCubeCoordinate(-1,  0, +1), new HexagonCubeCoordinate( 0, -1, +1)],
		[new HexagonCubeCoordinate(+1, -2, +1), new HexagonCubeCoordinate(+2, -2,  0),
		 new HexagonCubeCoordinate(+2, -1, -1), new HexagonCubeCoordinate(+2,  0, -2),
		 new HexagonCubeCoordinate(+1, +1, -2), new HexagonCubeCoordinate( 0, +2, -2),
		 new HexagonCubeCoordinate(-1, +2, -1), new HexagonCubeCoordinate(-2, +2,  0),
		 new HexagonCubeCoordinate(-2, +1, +1), new HexagonCubeCoordinate(-2,  0, +2),
		 new HexagonCubeCoordinate(-1, -1, +2), new HexagonCubeCoordinate( 0, -2, +2)]
	];

	//
	// Act
	//
	var _start = new HexagonCubeCoordinate(0, 0, 0);
	var _fringes = _system.hexagon_coordinate_system_reachable(_start, 2, _check_function);

	//
	// Assert
	//
	hexagon_assert_equal_2d_coordinate(_expected_fringes, _fringes);
}

/// @func hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached
/// @desc Verify which tiles that are considred as reachable when there are obstacles.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 100, 0, 0); 

	var _check_function = function(_hexagon)
	{
		var _blocked_hexagons = [new HexagonCubeCoordinate(+1, -1,  0), new HexagonCubeCoordinate(+2, -1, -1),
		                         new HexagonCubeCoordinate(-1, +1,  0), new HexagonCubeCoordinate(-2, +1, +1),
								 new HexagonCubeCoordinate(-2,  0, +2)];

		return !hexagon_exists_in_array(_blocked_hexagons, _hexagon);
	}

	var _expected_fringes = [
		[new HexagonCubeCoordinate( 0,  0,  0)],
		[new HexagonCubeCoordinate(+1,  0, -1), new HexagonCubeCoordinate( 0, +1, -1),
		 new HexagonCubeCoordinate(-1,  0, +1), new HexagonCubeCoordinate( 0, -1, +1)],
		[new HexagonCubeCoordinate(+2,  0, -2), new HexagonCubeCoordinate(+1, +1, -2),
		 new HexagonCubeCoordinate( 0, +2, -2), new HexagonCubeCoordinate(-1, +2, -1),
		 new HexagonCubeCoordinate(+1, -2, +1), new HexagonCubeCoordinate( 0, -2, +2),
		 new HexagonCubeCoordinate(-1, -1, +2)]
	];

	//
	// Act
	//
	var _start = new HexagonCubeCoordinate(0, 0, 0);
	var _fringes = _system.hexagon_coordinate_system_reachable(_start, 2, _check_function);

	//
	// Assert
	//
	hexagon_assert_equal_2d_coordinate(_expected_fringes, _fringes);
}

/// @func hexagon_coodinate_system_test_hex_to_pixel_pointy_top
/// @desc Verify that a hexagon position can be converted to x/y room position.
///       For a pointy topped hexagon coordinate system.
function hexagon_coodinate_system_test_hex_to_pixel_pointy_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.POINTY_TOP, 40, 0, 0); 

	//
	// Act
	//
	var _position = _system.hexagon_hex_to_pixel(new HexagonAxialCoordinate(-2, -1));

	//
	// Assert
	//
	hexagon_assert_equal(-173.2050807568877, _position.hexagon_position_x);
	hexagon_assert_equal(-60,                _position.hexagon_position_y);
}

/// @func hexagon_coodinate_system_test_hex_to_pixel_flat_top
/// @desc Verify that a hexagon position can be converted to x/y room position.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_hex_to_pixel_flat_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 40, 0, 0); 

	//
	// Act
	//
	var _position = _system.hexagon_hex_to_pixel(new HexagonAxialCoordinate(+3, 0));

	//
	// Assert
	//
	hexagon_assert_equal(180,                _position.hexagon_position_x);
	hexagon_assert_equal(103.92304845413264, _position.hexagon_position_y);
}

/// @func hexagon_coodinate_system_test_hex_to_pixel_flat_top_non_zero_origin
/// @desc Verify that a hexagon position can be converted to x/y room position.
///       For a flat topped hexagon coordinate system that has a non-zero origin.
function hexagon_coodinate_system_test_hex_to_pixel_flat_top_non_zero_origin()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 40, 10, 40); 

	//
	// Act
	//
	var _position = _system.hexagon_hex_to_pixel(new HexagonAxialCoordinate(+3, 0));

	//
	// Assert
	//
	hexagon_assert_equal(190,                _position.hexagon_position_x);
	hexagon_assert_equal(143.92304845413264, _position.hexagon_position_y);
}

/// @func hexagon_coodinate_system_test_pixel_to_hex_pointy_top
/// @desc Verify that a x/y room position can be converted to a hexagon coordinate.
///       For a pointy topped hexagon coordinate system.
function hexagon_coodinate_system_test_pixel_to_hex_pointy_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.POINTY_TOP, 40, 0, 0); 

	//
	// Act
	//
	var _coordinate = _system.hexagon_pixel_to_hex(-173.2050807568877, -60);
	var _axial_coordinate = _coordinate.hexagon_coordinate_to_axial();

	//
	// Assert
	//
	hexagon_assert_equal(-2, _axial_coordinate.hexagon_axial_coordinate_q);
	hexagon_assert_equal(-1, _axial_coordinate.hexagon_axial_coordinate_r);
}

/// @func hexagon_coodinate_system_test_pixel_to_hex_flat_top
/// @desc Verify that a x/y room position can be converted to a hexagon coordinate.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_pixel_to_hex_flat_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 40, 0, 0); 

	//
	// Act
	//
	var _coordinate = _system.hexagon_pixel_to_hex(180, 103.92304845413264);
	var _axial_coordinate = _coordinate.hexagon_coordinate_to_axial();

	//
	// Assert
	//
	hexagon_assert_equal(+3, _axial_coordinate.hexagon_axial_coordinate_q);
	hexagon_assert_equal( 0, _axial_coordinate.hexagon_axial_coordinate_r);
}

/// @func hexagon_coodinate_system_test_pixel_to_hex_flat_top_with_origin
/// @desc Verify that a x/y room position can be converted to a hexagon coordinate.
///       For a flat topped hexagon coordinate system that has a non-zero origin.
function hexagon_coodinate_system_test_pixel_to_hex_flat_top_with_origin()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 40, 25, 25); 

	//
	// Act
	//
	var _coordinate = _system.hexagon_pixel_to_hex(205, 128.92304845413264);
	var _axial_coordinate = _coordinate.hexagon_coordinate_to_axial();

	//
	// Assert
	//
	hexagon_assert_equal(+3, _axial_coordinate.hexagon_axial_coordinate_q);
	hexagon_assert_equal( 0, _axial_coordinate.hexagon_axial_coordinate_r);
}

/// @func hexagon_coodinate_system_test_pixel_to_hex_rounded_flat_top
/// @desc Verify that when a x/y position is converted to a hexagon coordinate
///       the resulting coordinate is rounded.
///       For a flat topped hexagon coordinate system.
function hexagon_coodinate_system_test_pixel_to_hex_rounded_flat_top()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 40, 0, 0); 

	//
	// Act
	//
	var _coordinate = _system.hexagon_pixel_to_hex(190, 100);
	var _axial_coordinate = _coordinate.hexagon_coordinate_to_axial();

	//
	// Assert
	//
	hexagon_assert_equal(+3, _axial_coordinate.hexagon_axial_coordinate_q);
	hexagon_assert_equal( 0, _axial_coordinate.hexagon_axial_coordinate_r);
}

/// @func hexagon_coodinate_system_test_check_that_path_finding_works
/// @desc Verify that paths can be found between hexagons.
function hexagon_coodinate_system_test_check_that_path_finding_works()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 100, 0, 0);

	var _cost_function = function(_hexagon)
	{
		return 1;
	}

	var _allowed_function = function(_hexagon)
	{
		var _blocked_hexagons = [new HexagonCubeCoordinate( 0, -1, +1), new HexagonCubeCoordinate(+1, -1,  0),
		                         new HexagonCubeCoordinate(+1,  0, -1), new HexagonCubeCoordinate( 0, +1, -1)];

		return !hexagon_exists_in_array(_blocked_hexagons, _hexagon);
	}

	var _start = new HexagonCubeCoordinate(0, 0, 0);
	var _end = new HexagonCubeCoordinate(+3, -4, +1);

	//
	// Act
	//
	var _path = _system.hexagon_find_path(_start, _end, _cost_function, _allowed_function);

	//
	// Assert
	//
	hexagon_assert_equal(7, array_length(_path));
	
	var _path_end_on_goal = false;

	for (var _i = 0; _i < array_length(_path) - 1 && !_path_end_on_goal; _i++)
	{
		var _node_current = _path[_i];
		var _node_next = _path[_i + 1];

		var _connection_is_valid = false;

		var _neighboors = _node_current.hexagon_coordinate_neighbors();

		for (var _direction = HEXAGON_DIRECTION.R;
		     _direction < HEXAGON_DIRECTION.SIZE && !_connection_is_valid;
			 _direction++)
		{
			var _node_neighboor = _neighboors[_direction];

			if (_node_next.hexagon_coordinate_equals(_node_neighboor))
			{
				_connection_is_valid = true;
				break;
			}
		}

		if (!_connection_is_valid)
		{
			break;
		}
		else if (_node_next.hexagon_coordinate_equals(_end))
		{
			_path_end_on_goal = true;
		}
	}
	
	hexagon_assert_equal(true, _path_end_on_goal);
}

/// @func hexagon_coodinate_system_test_check_that_path_finding_takes_cost_into_account
/// @desc Verify that paths take hexagon travel cost into account.
function hexagon_coodinate_system_test_check_that_path_finding_takes_cost_into_account()
{
	//
	// Arrange
	//
	var _system = new HexagonCoordinateSystem(HEXAGON_TYPE.FLAT_TOP, 100, 0, 0);

	var _uniform_cost_function = function(_hexagon)
	{
		return 1;
	}

	var _mixed_cost_function = function(_hexagon)
	{
		var _expensive_hexagon = new HexagonCubeCoordinate(0, 0, 0);

		return _hexagon.hexagon_coordinate_equals(_expensive_hexagon) * 10;
	}

	var _allowed_function = function(_hexagon)
	{
		return true;
	}

	var _start = new HexagonCubeCoordinate(-1, 0, +1);
	var _end = new HexagonCubeCoordinate(+1, 0, -1);

	//
	// Act
	//
	var _path_uniform_cost = _system.hexagon_find_path(_start, _end, _uniform_cost_function, _allowed_function);
	var _path_mixed_cost = _system.hexagon_find_path(_start, _end, _mixed_cost_function, _allowed_function);

	//
	// Assert
	//
	hexagon_assert_equal(array_length(_path_uniform_cost) + 1, array_length(_path_mixed_cost));
}
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================
#endregion