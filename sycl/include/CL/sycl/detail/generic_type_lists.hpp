//==-------- generic_type_lists.hpp - SYCL Generic type lists --------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <CL/sycl/access/access.hpp>
#include <CL/sycl/detail/stl_type_traits.hpp>
#include <CL/sycl/detail/type_list.hpp>
#include <CL/sycl/half_type.hpp>

// Generic type name description, which serves as a description for all valid
// types of parameters to kernel functions

// Forward declaration
namespace cl {
namespace sycl {
template <typename T, int N> class vec;
} // namespace sycl
} // namespace cl

namespace cl {
namespace sycl {
namespace detail {
namespace gtl {
// floating point types
using scalar_half_list = type_list<half>;

using vector_half_list = type_list<vec<half, 1>, vec<half, 2>, vec<half, 3>,
                                   vec<half, 4>, vec<half, 8>, vec<half, 16>>;

using half_list = type_list<scalar_half_list, vector_half_list>;

using scalar_float_list = type_list<float>;

using vector_float_list =
    type_list<vec<float, 1>, vec<float, 2>, vec<float, 3>, vec<float, 4>,
              vec<float, 8>, vec<float, 16>>;

using float_list = type_list<scalar_float_list, vector_float_list>;

using scalar_double_list = type_list<double>;

using vector_double_list =
    type_list<vec<double, 1>, vec<double, 2>, vec<double, 3>, vec<double, 4>,
              vec<double, 8>, vec<double, 16>>;

using double_list = type_list<scalar_double_list, vector_double_list>;

using scalar_floating_list =
    type_list<scalar_float_list, scalar_double_list, scalar_half_list>;

using vector_floating_list =
    type_list<vector_float_list, vector_double_list, vector_half_list>;

using floating_list = type_list<scalar_floating_list, vector_floating_list>;

// geometric floating point types
using scalar_geo_half_list = type_list<half>;

using scalar_geo_float_list = type_list<float>;

using scalar_geo_double_list = type_list<double>;

using vector_geo_half_list =
    type_list<vec<half, 1>, vec<half, 2>, vec<half, 3>, vec<half, 4>>;

using vector_geo_float_list =
    type_list<vec<float, 1>, vec<float, 2>, vec<float, 3>, vec<float, 4>>;

using vector_geo_double_list =
    type_list<vec<double, 1>, vec<double, 2>, vec<double, 3>, vec<double, 4>>;

using geo_half_list = type_list<scalar_geo_half_list, vector_geo_half_list>;

using geo_float_list = type_list<scalar_geo_float_list, vector_geo_float_list>;

using geo_double_list =
    type_list<scalar_geo_double_list, vector_geo_double_list>;

using scalar_geo_list = type_list<scalar_geo_half_list, scalar_geo_float_list,
                                  scalar_geo_double_list>;

using vector_geo_list = type_list<vector_geo_half_list, vector_geo_float_list,
                                  vector_geo_double_list>;

using geo_list = type_list<scalar_geo_list, vector_geo_list>;

// cross floating point types
using cross_half_list = type_list<vec<half, 3>, vec<half, 4>>;

using cross_float_list = type_list<vec<float, 3>, vec<float, 4>>;

using cross_double_list = type_list<vec<double, 3>, vec<double, 4>>;

using cross_floating_list =
    type_list<cross_float_list, cross_double_list, cross_half_list>;

using scalar_default_char_list = type_list<char>;

using vector_default_char_list =
    type_list<vec<char, 1>, vec<char, 2>, vec<char, 3>, vec<char, 4>,
              vec<char, 8>, vec<char, 16>>;

using default_char_list =
    type_list<scalar_default_char_list, vector_default_char_list>;

using scalar_signed_char_list = type_list<signed char>;

using vector_signed_char_list =
    type_list<vec<signed char, 1>, vec<signed char, 2>, vec<signed char, 3>,
              vec<signed char, 4>, vec<signed char, 8>, vec<signed char, 16>>;

using signed_char_list =
    type_list<scalar_signed_char_list, vector_signed_char_list>;

using scalar_unsigned_char_list = type_list<unsigned char>;

using vector_unsigned_char_list =
    type_list<vec<unsigned char, 1>, vec<unsigned char, 2>,
              vec<unsigned char, 3>, vec<unsigned char, 4>,
              vec<unsigned char, 8>, vec<unsigned char, 16>>;

using unsigned_char_list =
    type_list<scalar_unsigned_char_list, vector_unsigned_char_list>;

using scalar_char_list =
    type_list<scalar_default_char_list, scalar_signed_char_list,
              scalar_unsigned_char_list>;

using vector_char_list =
    type_list<vector_default_char_list, vector_signed_char_list,
              vector_unsigned_char_list>;

using char_list = type_list<scalar_char_list, vector_char_list>;

// short int types
using scalar_signed_short_list = type_list<signed short>;

using vector_signed_short_list =
    type_list<vec<signed short, 1>, vec<signed short, 2>, vec<signed short, 3>,
              vec<signed short, 4>, vec<signed short, 8>,
              vec<signed short, 16>>;

using signed_short_list =
    type_list<scalar_signed_short_list, vector_signed_short_list>;

using scalar_unsigned_short_list = type_list<unsigned short>;

using vector_unsigned_short_list =
    type_list<vec<unsigned short, 1>, vec<unsigned short, 2>,
              vec<unsigned short, 3>, vec<unsigned short, 4>,
              vec<unsigned short, 8>, vec<unsigned short, 16>>;

using unsigned_short_list =
    type_list<scalar_unsigned_short_list, vector_unsigned_short_list>;

using scalar_short_list =
    type_list<scalar_signed_short_list, scalar_unsigned_short_list>;

using vector_short_list =
    type_list<vector_signed_short_list, vector_unsigned_short_list>;

using short_list = type_list<scalar_short_list, vector_short_list>;

// int types
using scalar_signed_int_list = type_list<signed int>;

using vector_signed_int_list =
    type_list<vec<signed int, 1>, vec<signed int, 2>, vec<signed int, 3>,
              vec<signed int, 4>, vec<signed int, 8>, vec<signed int, 16>>;

using signed_int_list =
    type_list<scalar_signed_int_list, vector_signed_int_list>;

using scalar_unsigned_int_list = type_list<unsigned int>;

using vector_unsigned_int_list =
    type_list<vec<unsigned int, 1>, vec<unsigned int, 2>, vec<unsigned int, 3>,
              vec<unsigned int, 4>, vec<unsigned int, 8>,
              vec<unsigned int, 16>>;

using unsigned_int_list =
    type_list<scalar_unsigned_int_list, vector_unsigned_int_list>;

using scalar_int_list =
    type_list<scalar_signed_int_list, scalar_unsigned_int_list>;

using vector_int_list =
    type_list<vector_signed_int_list, vector_unsigned_int_list>;

using int_list = type_list<scalar_int_list, vector_int_list>;

// long types
using scalar_signed_long_list = type_list<signed long>;

using vector_signed_long_list =
    type_list<vec<signed long, 1>, vec<signed long, 2>, vec<signed long, 3>,
              vec<signed long, 4>, vec<signed long, 8>, vec<signed long, 16>>;

using signed_long_list =
    type_list<scalar_signed_long_list, vector_signed_long_list>;

using scalar_unsigned_long_list = type_list<unsigned long>;

using vector_unsigned_long_list =
    type_list<vec<unsigned long, 1>, vec<unsigned long, 2>,
              vec<unsigned long, 3>, vec<unsigned long, 4>,
              vec<unsigned long, 8>, vec<unsigned long, 16>>;

using unsigned_long_list =
    type_list<scalar_unsigned_long_list, vector_unsigned_long_list>;

using scalar_long_list =
    type_list<scalar_signed_long_list, scalar_unsigned_long_list>;

using vector_long_list =
    type_list<vector_signed_long_list, vector_unsigned_long_list>;

using long_list = type_list<scalar_long_list, vector_long_list>;

// long long types
using scalar_signed_longlong_list = type_list<signed long long>;

using vector_signed_longlong_list =
    type_list<vec<signed long long, 1>, vec<signed long long, 2>,
              vec<signed long long, 3>, vec<signed long long, 4>,
              vec<signed long long, 8>, vec<signed long long, 16>>;

using signed_longlong_list =
    type_list<scalar_signed_longlong_list, vector_signed_longlong_list>;

using scalar_unsigned_longlong_list = type_list<unsigned long long>;

using vector_unsigned_longlong_list =
    type_list<vec<unsigned long long, 1>, vec<unsigned long long, 2>,
              vec<unsigned long long, 3>, vec<unsigned long long, 4>,
              vec<unsigned long long, 8>, vec<unsigned long long, 16>>;

using unsigned_longlong_list =
    type_list<scalar_unsigned_longlong_list, vector_unsigned_longlong_list>;

using scalar_longlong_list =
    type_list<scalar_signed_longlong_list, scalar_unsigned_longlong_list>;

using vector_longlong_list =
    type_list<vector_signed_longlong_list, vector_unsigned_longlong_list>;

using longlong_list = type_list<scalar_longlong_list, vector_longlong_list>;

// long integer types
using scalar_signed_long_integer_list =
    type_list<scalar_signed_long_list, scalar_signed_longlong_list>;

using vector_signed_long_integer_list =
    type_list<vector_signed_long_list, vector_signed_longlong_list>;

using signed_long_integer_list =
    type_list<scalar_signed_long_integer_list, vector_signed_long_integer_list>;

using scalar_unsigned_long_integer_list =
    type_list<scalar_unsigned_long_list, scalar_unsigned_longlong_list>;

using vector_unsigned_long_integer_list =
    type_list<vector_unsigned_long_list, vector_unsigned_longlong_list>;

using unsigned_long_integer_list = type_list<scalar_unsigned_long_integer_list,
                                             vector_unsigned_long_integer_list>;

using scalar_long_integer_list = type_list<scalar_signed_long_integer_list,
                                           scalar_unsigned_long_integer_list>;

using vector_long_integer_list = type_list<vector_signed_long_integer_list,
                                           vector_unsigned_long_integer_list>;

using long_integer_list =
    type_list<scalar_long_integer_list, vector_long_integer_list>;

// integer types
using scalar_signed_integer_list = type_list<
    conditional_t<std::is_signed<char>::value,
                  type_list<scalar_default_char_list, scalar_signed_char_list>,
                  scalar_signed_char_list>,
    scalar_signed_short_list, scalar_signed_int_list, scalar_signed_long_list,
    scalar_signed_longlong_list>;

using vector_signed_integer_list = type_list<
    conditional_t<std::is_signed<char>::value,
                  type_list<vector_default_char_list, vector_signed_char_list>,
                  vector_signed_char_list>,
    vector_signed_short_list, vector_signed_int_list, vector_signed_long_list,
    vector_signed_longlong_list>;

using signed_integer_list =
    type_list<scalar_signed_integer_list, vector_signed_integer_list>;

using scalar_unsigned_integer_list =
    type_list<conditional_t<std::is_unsigned<char>::value,
                            type_list<scalar_default_char_list,
                                      scalar_unsigned_char_list>,
                            scalar_unsigned_char_list>,
              scalar_unsigned_short_list, scalar_unsigned_int_list,
              scalar_unsigned_long_list, scalar_unsigned_longlong_list>;

using vector_unsigned_integer_list =
    type_list<conditional_t<std::is_unsigned<char>::value,
                            type_list<vector_default_char_list,
                                      vector_unsigned_char_list>,
                            vector_unsigned_char_list>,
              vector_unsigned_short_list, vector_unsigned_int_list,
              vector_unsigned_long_list, vector_unsigned_longlong_list>;

using unsigned_integer_list =
    type_list<scalar_unsigned_integer_list, vector_unsigned_integer_list>;

using scalar_integer_list =
    type_list<scalar_signed_integer_list, scalar_unsigned_integer_list>;

using vector_integer_list =
    type_list<vector_signed_integer_list, vector_unsigned_integer_list>;

using integer_list = type_list<scalar_integer_list, vector_integer_list>;

// basic types
using scalar_signed_basic_list =
    type_list<scalar_floating_list, scalar_signed_integer_list>;

using vector_signed_basic_list =
    type_list<vector_floating_list, vector_signed_integer_list>;

using signed_basic_list =
    type_list<scalar_signed_basic_list, vector_signed_basic_list>;

using scalar_unsigned_basic_list = type_list<scalar_unsigned_integer_list>;

using vector_unsigned_basic_list = type_list<vector_unsigned_integer_list>;

using unsigned_basic_list =
    type_list<scalar_unsigned_basic_list, vector_unsigned_basic_list>;

using scalar_basic_list =
    type_list<scalar_signed_basic_list, scalar_unsigned_basic_list>;

using vector_basic_list =
    type_list<vector_signed_basic_list, vector_unsigned_basic_list>;

using basic_list = type_list<scalar_basic_list, vector_basic_list>;

// nan builtin types
using nan_list = type_list<gtl::unsigned_short_list, gtl::unsigned_int_list,
                           gtl::unsigned_long_integer_list>;
} // namespace gtl
namespace gvl {
// address spaces
using all_address_space_list =
    address_space_list<access::address_space::local_space,
                       access::address_space::global_space,
                       access::address_space::private_space,
                       access::address_space::constant_space>;

using nonconst_address_space_list =
    address_space_list<access::address_space::local_space,
                       access::address_space::global_space,
                       access::address_space::private_space>;

using nonlocal_address_space_list =
    address_space_list<access::address_space::global_space,
                       access::address_space::private_space,
                       access::address_space::constant_space>;
} // namespace gvl
} // namespace detail
} // namespace sycl
} // namespace cl
