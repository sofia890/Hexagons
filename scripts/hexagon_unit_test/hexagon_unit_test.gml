gml_pragma("global", "hexagon_unit_tests_init()");

//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
#macro Default:HEXAGON_RUN_UNIT_TESTS false
#macro Default:HEXAGON_BREAK_ON_ASSERTS false
#macro Default:HEXAGON_STOP_AFTER_FIRST false
#macro UnitTests:HEXAGON_RUN_UNIT_TESTS true
#macro UnitTests:HEXAGON_BREAK_ON_ASSERTS true
#macro UnitTests:HEXAGON_STOP_AFTER_FIRST true
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================

/// @func hexagon_unit_tests_init
/// @desc Initialze unit testing and determine if unit tests should be executed.
function hexagon_unit_tests_init()
{
	if (HEXAGON_RUN_UNIT_TESTS)
	{
		hexagon_unit_test_run_all();
	}
}

/// @func hexagon_unit_test_run_all
/// @desc Run all hexagon API unit tests.
function hexagon_unit_test_run_all()
{
	hexagon_coodinate_system_test_check_hexagon_dimensions_flat_top();
	hexagon_coodinate_system_test_check_hexagon_dimensions_pointy_top();
	hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached_no_obstacles();
	hexagon_coodinate_system_test_check_which_hexagons_that_can_be_reached();
	hexagon_coodinate_system_test_hex_to_pixel_pointy_top();
	hexagon_coodinate_system_test_hex_to_pixel_flat_top();
	hexagon_coodinate_system_test_hex_to_pixel_flat_top_non_zero_origin();
	hexagon_coodinate_system_test_pixel_to_hex_pointy_top();
	hexagon_coodinate_system_test_pixel_to_hex_flat_top();
	hexagon_coodinate_system_test_pixel_to_hex_flat_top_with_origin();
	hexagon_coodinate_system_test_pixel_to_hex_rounded_flat_top();
	hexagon_coodinate_system_test_check_that_path_finding_works();
	hexagon_coodinate_system_test_check_that_path_finding_takes_cost_into_account();
	hexagon_axial_coordinate_test_conversion_to_cube();

	game_end(0);
}
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================
#endregion