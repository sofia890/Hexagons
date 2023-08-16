//=================================================================================================
#region Enums & constants =========================================================================
//=================================================================================================

#endregion

//=================================================================================================
#region Functions =================================================================================
//=================================================================================================

/// @func hexagon_assert_equal
/// @desc Helper function for tests.
/// @param {any} _expected_value The value that is expected.
/// @param {any} _encountered_value The value that was encountered.
function hexagon_assert_equal(_expected_value, _encountered_value, _format = "", _format_data = [])
{
	if (_expected_value != _encountered_value)
	{
		var _extra_string = "";

		if (_format != "")
		{
			_extra_string = string(_format, _format_data);
		}

		show_error(string("Expected {0}, encountered {1}!" + _extra_string,
		                  _expected_value,
						  _encountered_value),
				   HEXAGON_STOP_AFTER_FIRST);
	}
}


/// @func hexagon_assert_equal_2d_coordinate
/// @desc Helper function for tests. Only checks that all elements exist on the expected depth.
/// @param {Array<Array<any>>} _expected_value The value that is expected.
/// @param {Array<Array<any>>} _encountered_value The value that was encountered.
function hexagon_assert_equal_2d_coordinate(_expected_value, _encountered_value, _format = "", _format_data = [])
{
	//
	// Label string
	//
	var _extra_string = "";

	if (_format != "")
	{
		_extra_string = string(_format, _format_data);
	}

	//
	// First dimension
	//
	if (array_length(_expected_value) != array_length(_encountered_value))
	{
		show_error(string("Expected array length {0}, encountered {1}!" + _extra_string,
		                  [array_length(_expected_value), array_length(_encountered_value)]),
					HEXAGON_STOP_AFTER_FIRST);
	}

	//
	// second dimension
	//
	for (var _i = 0; _i < array_length(_encountered_value); _i++)
	{
		for (var _j = 0; _j < array_length(_encountered_value[_i]); _j++)
		{
			var _element_found = false;
			var _element = _encountered_value[_i][_j];

			for (var _k = 0; _k < array_length(_expected_value[_i]) && !_element_found; _k++)
			{
				_element_found = (_element.hexagon_coordinate_equals(_expected_value[_i][_k]));
			}

			if (!_element_found)
			{
				show_error(string("{0} is not expected in {1}!" + _extra_string,
				                  [_element, _expected_value[_i]]),
						   HEXAGON_STOP_AFTER_FIRST);
			}
		}
	}
}

function hexagon_show_error(_message, _break_on_error)
{
	if (HEXAGON_BREAK_ON_ASSERTS)
	{
		show_error(_message, _break_on_error);
	}
	else
	{
		show_debug_message(_message);
	}
}
#endregion

//=================================================================================================
#region Structs ===================================================================================
//=================================================================================================
#endregion