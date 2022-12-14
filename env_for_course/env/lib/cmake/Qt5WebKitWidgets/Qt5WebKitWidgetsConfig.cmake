
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() (ECM variant) #######
####### Any changes to this file will be overwritten by the next CMake run            #######
####### The input file was Qt5WebKitWidgetsConfig.cmake.in                                           #######

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

include(CMakeFindDependencyMacro OPTIONAL RESULT_VARIABLE _CMakeFindDependencyMacro_FOUND)

if (NOT _CMakeFindDependencyMacro_FOUND)
  macro(find_dependency dep)
    if (NOT ${dep}_FOUND)

      set(ecm_fd_version)
      if (${ARGC} GREATER 1)
        set(ecm_fd_version ${ARGV1})
      endif()
      set(ecm_fd_exact_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_VERSION_EXACT)
        set(ecm_fd_exact_arg EXACT)
      endif()
      set(ecm_fd_quiet_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
        set(ecm_fd_quiet_arg QUIET)
      endif()
      set(ecm_fd_required_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_REQUIRED)
        set(ecm_fd_required_arg REQUIRED)
      endif()

      find_package(${dep} ${ecm_fd_version}
          ${ecm_fd_exact_arg}
          ${ecm_fd_quiet_arg}
          ${ecm_fd_required_arg}
      )

      if (NOT ${dep}_FOUND)
        set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "${CMAKE_FIND_PACKAGE_NAME} could not be found because dependency ${dep} could not be found.")
        set(${CMAKE_FIND_PACKAGE_NAME}_FOUND False)
        return()
      endif()

      set(ecm_fd_version)
      set(ecm_fd_required_arg)
      set(ecm_fd_quiet_arg)
      set(ecm_fd_exact_arg)
    endif()
  endmacro()
endif()


macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

macro(find_dependency_with_major_and_minor _dep _major _minor)
    find_dependency(${_dep} "${_major}.${_minor}")
    if (NOT("${${_dep}_VERSION_MAJOR}" STREQUAL "${_major}" AND "${${_dep}_VERSION_MINOR}" STREQUAL "${_minor}"))
        set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "${CMAKE_FIND_PACKAGE_NAME} could not be found because dependency ${dep} is required to have exact version ${_major}.${_minor}.x.")
        set(${CMAKE_FIND_PACKAGE_NAME}_FOUND False)
        return()
    endif ()
endmacro ()

####################################################################################


find_dependency(Qt5WebKit 5.212.0 EXACT)
find_dependency_with_major_and_minor(Qt5Widgets 5 15)

include("${CMAKE_CURRENT_LIST_DIR}/Qt5WebKitWidgetsTargets.cmake")

set(_Qt5WebKitWidgets_MODULE_DEPENDENCIES "WebKit;Widgets;Gui;Network;Core")
set(Qt5WebKitWidgets_DEFINITIONS -DQT_WEBKITWIDGETS_LIB)


####### Expanded from QTWEBKIT_PACKAGE_FOOTER variable #######

set(Qt5WebKitWidgets_LIBRARIES Qt5::WebKitWidgets)
set(Qt5WebKitWidgets_VERSION_STRING ${Qt5WebKitWidgets_VERSION})
set(Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS "")
set(Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS "") # FIXME: Support private headers

get_target_property(Qt5WebKitWidgets_INCLUDE_DIRS        Qt5::WebKitWidgets INTERFACE_INCLUDE_DIRECTORIES)
get_target_property(Qt5WebKitWidgets_COMPILE_DEFINITIONS Qt5::WebKitWidgets INTERFACE_COMPILE_DEFINITIONS)

foreach (_module_dep ${_Qt5WebKitWidgets_MODULE_DEPENDENCIES})
    list(APPEND Qt5WebKitWidgets_INCLUDE_DIRS ${Qt5${_module_dep}_INCLUDE_DIRS})
    list(APPEND Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS ${Qt5${_module_dep}_PRIVATE_INCLUDE_DIRS})
    list(APPEND Qt5WebKitWidgets_DEFINITIONS ${Qt5${_module_dep}_DEFINITIONS})
    list(APPEND Qt5WebKitWidgets_COMPILE_DEFINITIONS ${Qt5${_module_dep}_COMPILE_DEFINITIONS})
    list(APPEND Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS ${Qt5${_module_dep}_EXECUTABLE_COMPILE_FLAGS})
endforeach ()
list(REMOVE_DUPLICATES Qt5WebKitWidgets_INCLUDE_DIRS)
list(REMOVE_DUPLICATES Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS)
list(REMOVE_DUPLICATES Qt5WebKitWidgets_DEFINITIONS)
list(REMOVE_DUPLICATES Qt5WebKitWidgets_COMPILE_DEFINITIONS)
list(REMOVE_DUPLICATES Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS)

# Fixup order of configurations to match behavior of other Qt modules
# See also https://bugreports.qt.io/browse/QTBUG-29186
get_target_property(_configurations Qt5::WebKitWidgets IMPORTED_CONFIGURATIONS)
list(FIND _configurations RELEASE _index)
if (${_index} GREATER -1)
    list(REMOVE_AT _configurations ${_index})
    list(INSERT _configurations 0 RELEASE)
    set_property(TARGET Qt5::WebKitWidgets PROPERTY IMPORTED_CONFIGURATIONS "${_configurations}")
endif ()
unset(_configurations)
unset(_index)

