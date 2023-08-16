//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================
enum HEXAGON_TYPE
{
	FLAT_TOP,
	POINTY_TOP
}
enum HEXAGON_COORDINATE_TYPE
{
	CUBE,
	AXIAL,
	UNKNOWN
}

#macro HEXAGON_PATH_MAX_LENGTH 1000
#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================

/// @func hexagon_exists_in_list
/// @desc Search for the index of a value.
/// @param {Id.DsList<struct.HexagonCoordinate>} _list List to search in.
/// @param {struct.HexagonCoordinate} _value Value to look for.
/// @return {bool} True when <_value> is found.
function hexagon_exists_in_list(_list, _value)
{
	var _list_size = ds_list_size(_list);

	for (var _i = 0; _i < _list_size; _i++)
	{
		var _element = _list[| _i];

		if (_element.hexagon_coordinate_equals(_value))
		{
			return true;
		}
	}
		
	return false;
}

/// @func hexagon_exists_in_array
/// @desc Search for the index of a value.
/// @param {Array<struct.HexagonCoordinate>} _array List to search in.
/// @param {struct.HexagonCoordinate} _value Value to look for.
/// @return {bool} True when <_value> is found.
function hexagon_exists_in_array(_array, _value)
{
	var _list_size = array_length(_array);

	for (var _i = 0; _i < _list_size; _i++)
	{
		var _element = _array[_i];

		if (_element.hexagon_coordinate_equals(_value))
		{
			return true;
		}
	}
		
	return false;
}
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================

/// @func HexagonCoordinateSystem
/// @desc Representation of a hexagon coordinate system, provides helper functions for interacting
///       with the system.
/// @param {enum.HEXAGON_TYPE} _hexagon_type Hexagon type.
/// @param {real} _hexagon_size The size of the heaxon, from the center to each point.
/// @param {real} _origin_x X-axis origin, this is in room coordinates.
/// @param {real} _origin_y Y-axis origin, this is in room coordinates.
function HexagonCoordinateSystem(_hexagon_type, _hexagon_size, _origin_x, _origin_y) constructor
{
	//=============================================================================================
	#region New functions =========================================================================
	//=============================================================================================
	
	/// @func hexagon_distance_between_points
	/// @desc Get the distance between opposite points.
	/// @ignore
	function hexagon_distance_between_points()
	{
		return hexagon_coordinate_system_size * sqrt(3);
	}

	/// @func hexagon_distance_between_walls
	/// @desc Get the distance between opposite walls.
	/// @ignore
	function hexagon_distance_between_walls()
	{
		return hexagon_coordinate_system_size * 2;
	}

	/// @func hexagon_get_hexagon_width
	/// @desc Get the with of a hexagon.
	function hexagon_get_hexagon_width()
	{
		if (hexagon_coordinate_system_type == HEXAGON_TYPE.FLAT_TOP)
		{
			return hexagon_distance_between_walls();
		}
		else if (hexagon_coordinate_system_type == HEXAGON_TYPE.POINTY_TOP)
		{
			return hexagon_distance_between_points();
		}
	}

	/// @func hexagon_coordinate_system_get_hexagon_height
	/// @desc Get the height of a hexagon.
	function hexagon_get_hexagon_height()
	{
		if (hexagon_coordinate_system_type == HEXAGON_TYPE.FLAT_TOP)
		{
			return hexagon_distance_between_points();
		}
		else if (hexagon_coordinate_system_type == HEXAGON_TYPE.POINTY_TOP)
		{
			return hexagon_distance_between_walls();
		}
	}

	/// @func hexagon_coordinate_system_reachable
	/// @desc Determine which coordinates that can be reached.
	/// @param {struct.HexagonCoordinate} _start Start position.
	/// @param {real} _max_movement The maximum number of steps.
	/// @param {function} _func_hexagon_check Function that is used to evaluate if a hexagon can be
	///                                       be stepped onto. Function is called with a single argument
	///                                       HexagonCoordinate. The function should return true for
	///                                       hexagons that can be visited.
	/// @return {Array<Array<struct.HexagonCoordinate>>} The reachable hexagons grouped by steps needed
	///                                                  to reach the hexagon. The first index contains
	///                                                  only <_start>. Index 1 contains all hexagons
	///                                                  which require 1 step in order to be reached.
	function hexagon_coordinate_system_reachable(_start, _max_movement, _func_hexagon_check)
	{
		//
		// Prepare fringes array
		//
		var _fringes = [[_start]];

		//
		// Steps 1 to N
		//
		var _visited = ds_list_create();
		ds_list_add(_visited, _start);

		for (var _i = 1; _i <= _max_movement; _i++)
		{
			var _fringes_current_step = [];
			var _fringes_current_step_next_index = 0;

			var _nrof_hexagons_to_check = array_length(_fringes[_i - 1]);

			for (var _j = 0; _j < _nrof_hexagons_to_check; _j++)
			{
				var _neighbors = _fringes[_i - 1][_j].hexagon_coordinate_neighbors();
				
				for (var _direction = HEXAGON_DIRECTION.R;
				     _direction < HEXAGON_DIRECTION.SIZE;
					 _direction++)
				{
					var _hexagon = _neighbors[_direction];
					
					if (!hexagon_exists_in_list(_visited, _hexagon) &&
					    _func_hexagon_check(_hexagon))
					{
						ds_list_add(_visited, _hexagon);

						_fringes_current_step[_fringes_current_step_next_index++] = _hexagon;
					}
				}
			}
			
			_fringes[_i] = _fringes_current_step;
		}

		ds_list_destroy(_visited);

		return _fringes;
	}

	/// @func hexagon_hex_to_pixel
	/// @desc Convert a hexagon position to a x/y position.
	/// @param {struct.HexagonCoordinate} _coordinate Coordinate to convert.
	/// @return {struct.HexagonPosition} X/Y coordinate.
	function hexagon_hex_to_pixel(_coordinate)
	{
		var _axial_coordinate = _coordinate.hexagon_coordinate_to_axial();
		var _q = _axial_coordinate.hexagon_axial_coordinate_q;
		var _r = _axial_coordinate.hexagon_axial_coordinate_r;
		var _size = hexagon_coordinate_system_size;

		var _x = hexagon_coordinate_system_origin_x;
		var _y = hexagon_coordinate_system_origin_y;

		if (hexagon_coordinate_system_type == HEXAGON_TYPE.POINTY_TOP)
		{
			_x += _size * (sqrt(3) * _q + (sqrt(3) / 2) * _r);
			_y += _size * (               (      3 / 2) * _r);
		}
		else if (hexagon_coordinate_system_type == HEXAGON_TYPE.FLAT_TOP)
		{
			_x += _size * ((      3 / 2) * _q               );
			_y += _size * ((sqrt(3) / 2) * _q + sqrt(3) * _r);
		}

		return new HexagonPosition(_x, _y);
	}

	/// @func hexagon_pixel_to_hex
	/// @desc Get the height of a hexagon.
	/// @param {real} _x X-axis coordinate.
	/// @param {real} _y Y-axis coordinate.
	/// @return {struct.HexagonCoordinate} Hexagon coordinate.
	function hexagon_pixel_to_hex(_x, _y)
	{
		//
		// Convert to hex coordinate
		//
		var _x_local = _x - hexagon_coordinate_system_origin_x;
		var _y_local = _y - hexagon_coordinate_system_origin_y;
		
		var _size = hexagon_coordinate_system_size;

		var _q;
		var _r;

		if (hexagon_coordinate_system_type == HEXAGON_TYPE.POINTY_TOP)
		{
			_q = ((sqrt(3) / 3) * _x_local - (1 / 3) * _y_local) / _size;
			_r = (                           (2 / 3) * _y_local) / _size;
		}
		else if (hexagon_coordinate_system_type == HEXAGON_TYPE.FLAT_TOP)
		{
			_q = (( 2 / 3) * _x_local                           ) / _size;
			_r = ((-1 / 3) * _x_local + (sqrt(3) / 3) * _y_local) / _size;
		}

		//
		// Round to hex origin
		//
		var _axial_coordinate = new HexagonAxialCoordinate(_q, _r);
		var _cube_coordinate = _axial_coordinate.hexagon_coordinate_to_cube();

		var _q_rounded = round(_cube_coordinate.hexagon_cube_coordinate_q);
		var _r_rounded = round(_cube_coordinate.hexagon_cube_coordinate_r);
		var _s_rounded = round(_cube_coordinate.hexagon_cube_coordinate_s);

		var _s = _cube_coordinate.hexagon_cube_coordinate_s;

		var _q_diff = abs(_q_rounded - _q);
		var _r_diff = abs(_r_rounded - _r);
		var _s_diff = abs(_s_rounded - _s);

		if (_q_diff > _r_diff && _q_diff > _s_diff)
		{
			_q_rounded = -_r_rounded - _s_rounded;
		}
		else if (_r_diff > _s_diff)
		{
			_r_rounded = -_q_rounded - _s_rounded;
		}
		else if (_q_diff > _r_diff && _q_diff > _s_diff)
		{
			_s_rounded = -_q_rounded - _r_rounded;
		}

		return new HexagonCubeCoordinate(_q_rounded, _r_rounded, _s_rounded);
	}

	/// @func hexagon_find_path
	/// @desc Get the path between two coordinates.
	/// @param {struct.HexagonCoordinate} _coordinate_start Starting coortdinate.
	/// @param {struct.HexagonCoordinate} _coordinate_goal Goal coortdinate.
	/// @param {function} _func_travel_cost Function that is used to check if a hexagon can be traversed.
	///                                     Function is called with a single argument:
	///                                     HexagonCoordinate. Should return true when a hexagon can
	///										be traversed.
	/// @param {function} _func_travel_allowed Function that is used to get the cost of traveling over
	///                                        a hexagon. Function is called with a single argument:
	///                                        HexagonCoordinate. The function should return the cost
	///                                        of travel.
	/// @return {Array<struct.HexagonCoordinate>} Path created by traversing a set of coordinates.
	///                                           An emoty array means no path could be found.
	function hexagon_find_path(_coordinate_start, _coordinate_goal, _func_travel_cost, _func_travel_allowed)
	{
		//
		// Prepare
		//
		var _frontier = ds_priority_create();
		ds_priority_add(_frontier, _coordinate_start, 0);


		var _came_from = ds_map_create();

		var _cost_so_far = ds_map_create();

		var _start_key = _coordinate_start.hexagon_coordinate_to_string();
		_cost_so_far[? _start_key] = 0;

		//
		// Traverse coordinate system
		//
		var _found = false;

		while (!ds_priority_empty(_frontier))
		{
			var _current = ds_priority_delete_min(_frontier);

			var _current_key = _current.hexagon_coordinate_to_string();

			if (_current.hexagon_coordinate_equals(_coordinate_goal))
			{
				_found =  true;
				break;
			}
			
			var _neighboors = _current.hexagon_coordinate_neighbors();

			for (var _direction = HEXAGON_DIRECTION.R; _direction < HEXAGON_DIRECTION.SIZE; _direction++)
			{
				var _next = _neighboors[_direction];

				var _next_key = _next.hexagon_coordinate_to_string();

				var _new_cost = _cost_so_far[? _current_key] + real(_func_travel_cost(_next));

				if ((!ds_map_exists(_cost_so_far, _next_key) || _new_cost < _cost_so_far[? _next_key]) &&
					_func_travel_allowed(_next))
				{
					_cost_so_far[? _next_key] = _new_cost;

					var _priority = _new_cost + _next.hexagon_coordinate_distance(_coordinate_goal);
					ds_priority_add(_frontier, _next, _priority);

					_came_from[? _next_key] = _current;
				}
			}
		}

		ds_map_destroy(_cost_so_far);

		ds_priority_destroy(_frontier);
		
		//
		// Create path
		//
		var _path = [];

		if (_found)
		{
			var _path_stack = ds_stack_create();

			var _current = _coordinate_goal;

			ds_stack_push(_path_stack, _current)
		
			while (!_current.hexagon_coordinate_equals(_coordinate_start))
			{
				var _next = _came_from[? _current.hexagon_coordinate_to_string()];

				ds_stack_push(_path_stack, _next)

				_current = _next;
			}
			
			if (ds_stack_size(_path_stack) <= HEXAGON_PATH_MAX_LENGTH)
			{
				var _path_index = 0;

				while (!ds_stack_empty(_path_stack))
				{
					_path[_path_index++] = ds_stack_pop(_path_stack)
				}
			}

			ds_stack_destroy(_path_stack);
		}

		ds_map_destroy(_came_from);

		return _path;
	}
	#endregion

	//=============================================================================================
	#region Overriden functions ===================================================================
	//=============================================================================================
	#endregion

	//=============================================================================================
	#region New variables =========================================================================
	//=============================================================================================
	/// @ignore
	hexagon_coordinate_system_type = _hexagon_type;
	/// @ignore
	hexagon_coordinate_system_size = _hexagon_size;
	/// @ignore
	hexagon_coordinate_system_origin_x = _origin_x;
	/// @ignore
	hexagon_coordinate_system_origin_y = _origin_y;
	#endregion

	//=============================================================================================
	#region Constructor ===========================================================================
	//=============================================================================================
	#endregion
}

#endregion