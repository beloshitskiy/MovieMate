/*
 * Author: Landon Fuller <landonf@plausible.coop>
 *
 * Copyright (c) 2012-2013 Plausible Labs Cooperative, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * For external library integrators:
 *
 * Set this value to any valid C symbol prefix. This will automatically
 * prepend the given prefix to all external symbols in the library.
 *
 * This may be used to avoid symbol conflicts between multiple libraries
 * that may both incorporate OKCrashReporter.
 */
// #define OKCRASHREPORTER_PREFIX AcmeCo


// We need two extra layers of indirection to make CPP substitute
// the OKCRASHREPORTER_PREFIX define.
#define OKNS_impl2(prefix, symbol) prefix ## symbol
#define OKNS_impl(prefix, symbol) OKNS_impl2(prefix, symbol)
#define OKNS(symbol) OKNS_impl(OKCRASHREPORTER_PREFIX, symbol)


/*
 * Rewrite all ObjC/C symbols.
 *
 * For C++ symbol handling, refer to the OKCR_CPP_BEGIN_NS and OKCR_CPP_END_NS
 * macros.
 */
#ifdef OKCRASHREPORTER_PREFIX

/* Objective-C Classes */
#define OKCrashMachExceptionServer          OKNS(OKCrashMachExceptionServer)
#define OKCrashReport                       OKNS(OKCrashReport)
#define OKCrashReportApplicationInfo        OKNS(OKCrashReportApplicationInfo)
#define OKCrashReportBinaryImageInfo        OKNS(OKCrashReportBinaryImageInfo)
#define OKCrashReportExceptionInfo          OKNS(OKCrashReportExceptionInfo)
#define OKCrashReportMachExceptionInfo      OKNS(OKCrashReportMachExceptionInfo)
#define OKCrashReportMachineInfo            OKNS(OKCrashReportMachineInfo)
#define OKCrashReportProcessInfo            OKNS(OKCrashReportProcessInfo)
#define OKCrashReportProcessorInfo          OKNS(OKCrashReportProcessorInfo)
#define OKCrashReportRegisterInfo           OKNS(OKCrashReportRegisterInfo)
#define OKCrashReportSignalInfo             OKNS(OKCrashReportSignalInfo)
#define OKCrashReportStackFrameInfo         OKNS(OKCrashReportStackFrameInfo)
#define OKCrashReportSymbolInfo             OKNS(OKCrashReportSymbolInfo)
#define OKCrashReportSystemInfo             OKNS(OKCrashReportSystemInfo)
#define OKCrashReportTextFormatter          OKNS(OKCrashReportTextFormatter)
#define OKCrashReportThreadInfo             OKNS(OKCrashReportThreadInfo)
#define OKCrashReporter                     OKNS(OKCrashReporter)
#define OKCrashSignalHandler                OKNS(OKCrashSignalHandler)
#define OKCrashHostInfo                     OKNS(OKCrashHostInfo)
#define OKCrashMachExceptionPort            OKNS(OKCrashMachExceptionPort)
#define OKCrashMachExceptionPortSet         OKNS(OKCrashMachExceptionPortSet)
#define OKCrashProcessInfo                  OKNS(OKCrashProcessInfo)
#define OKCrashReporterConfig               OKNS(OKCrashReporterConfig)
#define OKCrashUncaughtExceptionHandler     OKNS(OKCrashUncaughtExceptionHandler)
#define OKCrashReportFormatter              OKNS(OKCrashReportFormatter)

/* Public C functions */
#define OKCrashMachExceptionForward         OKNS(OKCrashMachExceptionForward)
#define OKCrashSignalHandlerForward         OKNS(OKCrashSignalHandlerForward)
#define okcrash_signal_handler              OKNS(okcrash_signal_handler)


/* Public C global symbols */
#define OKCrashReporterErrorDomain          OKNS(OKCrashReporterErrorDomain)
#define OKCrashReportHostArchitecture       OKNS(OKCrashReportHostArchitecture)
#define OKCrashReportHostOperatingSystem    OKNS(OKCrashReportHostOperatingSystem)
#define OKCrashReporterException            OKNS(OKCrashReporterException)

/* For backwards compatibility, okcrash_async_byteorder vends C++ methods when included under C++. We have
 * to handle this distinctly from our OKCR_CPP_BEGIN_NS C++ namespacing mechanism. */
#define okcrash_async_byteorder             OKNS(okcrash_async_byteorder)

/*
 * All private C symbols. Once these are migrated to C++, we'll be able to use the much simpler
 * OKCR_CPP_BEGIN_NS machinery.
 *
 * This list was automatically generated (and can be updated) by setting OKCRASHREPORTER_PREFIX to 'AcmeCo',
 * building the library, and executing the following:
 * nm -g -U <static library> | grep '^[0-9]' | c++filt | grep -v AcmeCo | grep -E '_pl|_PL' | awk '{print $3}' | cut -c 2- | sort | uniq | awk '{print "#define",$1,"OKNS("$1")"}'
 */
#define ok_mach_thread_self OKNS(ok_mach_thread_self)
#define oktracer__architecture__descriptor OKNS(oktracer__architecture__descriptor)
#define oktracer__crash_report__application_info__descriptor OKNS(oktracer__crash_report__application_info__descriptor)
#define oktracer__crash_report__application_info__init OKNS(oktracer__crash_report__application_info__init)
#define oktracer__crash_report__binary_image__descriptor OKNS(oktracer__crash_report__binary_image__descriptor)
#define oktracer__crash_report__binary_image__init OKNS(oktracer__crash_report__binary_image__init)
#define oktracer__crash_report__descriptor OKNS(oktracer__crash_report__descriptor)
#define oktracer__crash_report__exception__descriptor OKNS(oktracer__crash_report__exception__descriptor)
#define oktracer__crash_report__exception__init OKNS(oktracer__crash_report__exception__init)
#define oktracer__crash_report__free_unpacked OKNS(oktracer__crash_report__free_unpacked)
#define oktracer__crash_report__get_packed_size OKNS(oktracer__crash_report__get_packed_size)
#define oktracer__crash_report__init OKNS(oktracer__crash_report__init)
#define oktracer__crash_report__machine_info__descriptor OKNS(oktracer__crash_report__machine_info__descriptor)
#define oktracer__crash_report__machine_info__init OKNS(oktracer__crash_report__machine_info__init)
#define oktracer__crash_report__pack OKNS(oktracer__crash_report__pack)
#define oktracer__crash_report__pack_to_buffer OKNS(oktracer__crash_report__pack_to_buffer)
#define oktracer__crash_report__process_info__descriptor OKNS(oktracer__crash_report__process_info__descriptor)
#define oktracer__crash_report__process_info__init OKNS(oktracer__crash_report__process_info__init)
#define oktracer__crash_report__processor__descriptor OKNS(oktracer__crash_report__processor__descriptor)
#define oktracer__crash_report__processor__init OKNS(oktracer__crash_report__processor__init)
#define oktracer__crash_report__processor__type_encoding__descriptor OKNS(oktracer__crash_report__processor__type_encoding__descriptor)
#define oktracer__crash_report__report_info__descriptor OKNS(oktracer__crash_report__report_info__descriptor)
#define oktracer__crash_report__report_info__init OKNS(oktracer__crash_report__report_info__init)
#define oktracer__crash_report__signal__descriptor OKNS(oktracer__crash_report__signal__descriptor)
#define oktracer__crash_report__signal__init OKNS(oktracer__crash_report__signal__init)
#define oktracer__crash_report__signal__mach_exception__descriptor OKNS(oktracer__crash_report__signal__mach_exception__descriptor)
#define oktracer__crash_report__signal__mach_exception__init OKNS(oktracer__crash_report__signal__mach_exception__init)
#define oktracer__crash_report__symbol__descriptor OKNS(oktracer__crash_report__symbol__descriptor)
#define oktracer__crash_report__symbol__init OKNS(oktracer__crash_report__symbol__init)
#define oktracer__crash_report__system_info__descriptor OKNS(oktracer__crash_report__system_info__descriptor)
#define oktracer__crash_report__system_info__init OKNS(oktracer__crash_report__system_info__init)
#define oktracer__crash_report__system_info__operating_system__descriptor OKNS(oktracer__crash_report__system_info__operating_system__descriptor)
#define oktracer__crash_report__thread__descriptor OKNS(oktracer__crash_report__thread__descriptor)
#define oktracer__crash_report__thread__init OKNS(oktracer__crash_report__thread__init)
#define oktracer__crash_report__thread__register_value__descriptor OKNS(oktracer__crash_report__thread__register_value__descriptor)
#define oktracer__crash_report__thread__register_value__init OKNS(oktracer__crash_report__thread__register_value__init)
#define oktracer__crash_report__thread__stack_frame__descriptor OKNS(oktracer__crash_report__thread__stack_frame__descriptor)
#define oktracer__crash_report__thread__stack_frame__init OKNS(oktracer__crash_report__thread__stack_frame__init)
#define oktracer__crash_report__unpack OKNS(oktracer__crash_report__unpack)
#define okcrash_async_address_apply_offset OKNS(okcrash_async_address_apply_offset)
#define okcrash_async_byteorder_big_endian OKNS(okcrash_async_byteorder_big_endian)
#define okcrash_async_byteorder_direct OKNS(okcrash_async_byteorder_direct)
#define okcrash_async_byteorder_little_endian OKNS(okcrash_async_byteorder_little_endian)
#define okcrash_async_byteorder_swapped OKNS(okcrash_async_byteorder_swapped)
#define okcrash_async_cfe_entry_apply OKNS(okcrash_async_cfe_entry_apply)
#define okcrash_async_cfe_entry_free OKNS(okcrash_async_cfe_entry_free)
#define okcrash_async_cfe_entry_init OKNS(okcrash_async_cfe_entry_init)
#define okcrash_async_cfe_entry_register_count OKNS(okcrash_async_cfe_entry_register_count)
#define okcrash_async_cfe_entry_register_list OKNS(okcrash_async_cfe_entry_register_list)
#define okcrash_async_cfe_entry_return_address_register OKNS(okcrash_async_cfe_entry_return_address_register)
#define okcrash_async_cfe_entry_stack_adjustment OKNS(okcrash_async_cfe_entry_stack_adjustment)
#define okcrash_async_cfe_entry_stack_offset OKNS(okcrash_async_cfe_entry_stack_offset)
#define okcrash_async_cfe_entry_type OKNS(okcrash_async_cfe_entry_type)
#define okcrash_async_cfe_reader_find_pc OKNS(okcrash_async_cfe_reader_find_pc)
#define okcrash_async_cfe_reader_free OKNS(okcrash_async_cfe_reader_free)
#define okcrash_async_cfe_reader_init OKNS(okcrash_async_cfe_reader_init)
#define okcrash_async_cfe_register_decode OKNS(okcrash_async_cfe_register_decode)
#define okcrash_async_cfe_register_encode OKNS(okcrash_async_cfe_register_encode)
#define okcrash_async_file_close OKNS(okcrash_async_file_close)
#define okcrash_async_file_flush OKNS(okcrash_async_file_flush)
#define okcrash_async_file_init OKNS(okcrash_async_file_init)
#define okcrash_async_file_write OKNS(okcrash_async_file_write)
#define okcrash_async_find_symbol OKNS(okcrash_async_find_symbol)
#define okcrash_async_image_containing_address OKNS(okcrash_async_image_containing_address)
#define okcrash_async_image_list_next OKNS(okcrash_async_image_list_next)
#define okcrash_async_image_list_set_reading OKNS(okcrash_async_image_list_set_reading)
#define okcrash_async_mach_exception_get_siginfo OKNS(okcrash_async_mach_exception_get_siginfo)
#define okcrash_async_macho_byteorder OKNS(okcrash_async_macho_byteorder)
#define okcrash_async_macho_contains_address OKNS(okcrash_async_macho_contains_address)
#define okcrash_async_macho_cpu_subtype OKNS(okcrash_async_macho_cpu_subtype)
#define okcrash_async_macho_cpu_type OKNS(okcrash_async_macho_cpu_type)
#define okcrash_async_macho_find_command OKNS(okcrash_async_macho_find_command)
#define okcrash_async_macho_find_segment_cmd OKNS(okcrash_async_macho_find_segment_cmd)
#define okcrash_async_macho_find_symbol_by_name OKNS(okcrash_async_macho_find_symbol_by_name)
#define okcrash_async_macho_find_symbol_by_pc OKNS(okcrash_async_macho_find_symbol_by_pc)
#define okcrash_async_macho_header OKNS(okcrash_async_macho_header)
#define okcrash_async_macho_header_size OKNS(okcrash_async_macho_header_size)
#define okcrash_async_macho_map_section OKNS(okcrash_async_macho_map_section)
#define okcrash_async_macho_map_segment OKNS(okcrash_async_macho_map_segment)
#define okcrash_async_macho_mapped_segment_free OKNS(okcrash_async_macho_mapped_segment_free)
#define okcrash_async_macho_next_command OKNS(okcrash_async_macho_next_command)
#define okcrash_async_macho_next_command_type OKNS(okcrash_async_macho_next_command_type)
#define okcrash_async_macho_string_free OKNS(okcrash_async_macho_string_free)
#define okcrash_async_macho_string_get_length OKNS(okcrash_async_macho_string_get_length)
#define okcrash_async_macho_string_get_pointer OKNS(okcrash_async_macho_string_get_pointer)
#define okcrash_async_macho_string_init OKNS(okcrash_async_macho_string_init)
#define okcrash_async_macho_symtab_reader_free OKNS(okcrash_async_macho_symtab_reader_free)
#define okcrash_async_macho_symtab_reader_init OKNS(okcrash_async_macho_symtab_reader_init)
#define okcrash_async_macho_symtab_reader_read OKNS(okcrash_async_macho_symtab_reader_read)
#define okcrash_async_macho_symtab_reader_symbol_name OKNS(okcrash_async_macho_symtab_reader_symbol_name)
#define okcrash_async_memcpy OKNS(okcrash_async_memcpy)
#define okcrash_async_memset OKNS(okcrash_async_memset)
#define okcrash_async_mobject_base_address OKNS(okcrash_async_mobject_base_address)
#define okcrash_async_mobject_free OKNS(okcrash_async_mobject_free)
#define okcrash_async_mobject_init OKNS(okcrash_async_mobject_init)
#define okcrash_async_mobject_length OKNS(okcrash_async_mobject_length)
#define okcrash_async_mobject_read_uint16 OKNS(okcrash_async_mobject_read_uint16)
#define okcrash_async_mobject_read_uint32 OKNS(okcrash_async_mobject_read_uint32)
#define okcrash_async_mobject_read_uint64 OKNS(okcrash_async_mobject_read_uint64)
#define okcrash_async_mobject_read_uint8 OKNS(okcrash_async_mobject_read_uint8)
#define okcrash_async_mobject_remap_address OKNS(okcrash_async_mobject_remap_address)
#define okcrash_async_mobject_task OKNS(okcrash_async_mobject_task)
#define okcrash_async_mobject_verify_local_pointer OKNS(okcrash_async_mobject_verify_local_pointer)
#define okcrash_async_objc_cache_free OKNS(okcrash_async_objc_cache_free)
#define okcrash_async_objc_cache_init OKNS(okcrash_async_objc_cache_init)
#define okcrash_async_objc_find_method OKNS(okcrash_async_objc_find_method)
#define okcrash_async_signal_sigcode OKNS(okcrash_async_signal_sigcode)
#define okcrash_async_signal_signame OKNS(okcrash_async_signal_signame)
#define okcrash_async_strcmp OKNS(okcrash_async_strcmp)
#define okcrash_async_strerror OKNS(okcrash_async_strerror)
#define okcrash_async_strncmp OKNS(okcrash_async_strncmp)
#define okcrash_async_symbol_cache_free OKNS(okcrash_async_symbol_cache_free)
#define okcrash_async_symbol_cache_init OKNS(okcrash_async_symbol_cache_init)
#define okcrash_async_task_memcpy OKNS(okcrash_async_task_memcpy)
#define okcrash_async_task_read_uint16 OKNS(okcrash_async_task_read_uint16)
#define okcrash_async_task_read_uint32 OKNS(okcrash_async_task_read_uint32)
#define okcrash_async_task_read_uint64 OKNS(okcrash_async_task_read_uint64)
#define okcrash_async_task_read_uint8 OKNS(okcrash_async_task_read_uint8)
#define okcrash_async_thread_state_clear_all_regs OKNS(okcrash_async_thread_state_clear_all_regs)
#define okcrash_async_thread_state_clear_reg OKNS(okcrash_async_thread_state_clear_reg)
#define okcrash_async_thread_state_clear_volatile_regs OKNS(okcrash_async_thread_state_clear_volatile_regs)
#define okcrash_async_thread_state_copy OKNS(okcrash_async_thread_state_copy)
#define okcrash_async_thread_state_current OKNS(okcrash_async_thread_state_current)
#define okcrash_async_thread_state_current_stub OKNS(okcrash_async_thread_state_current_stub)
#define okcrash_async_thread_state_get_greg_size OKNS(okcrash_async_thread_state_get_greg_size)
#define okcrash_async_thread_state_get_reg OKNS(okcrash_async_thread_state_get_reg)
#define okcrash_async_thread_state_get_reg_count OKNS(okcrash_async_thread_state_get_reg_count)
#define okcrash_async_thread_state_get_reg_name OKNS(okcrash_async_thread_state_get_reg_name)
#define okcrash_async_thread_state_get_stack_direction OKNS(okcrash_async_thread_state_get_stack_direction)
#define okcrash_async_thread_state_has_reg OKNS(okcrash_async_thread_state_has_reg)
#define okcrash_async_thread_state_init OKNS(okcrash_async_thread_state_init)
#define okcrash_async_thread_state_mach_thread_init OKNS(okcrash_async_thread_state_mach_thread_init)
#define okcrash_async_thread_state_map_dwarf_to_reg OKNS(okcrash_async_thread_state_map_dwarf_to_reg)
#define okcrash_async_thread_state_map_reg_to_dwarf OKNS(okcrash_async_thread_state_map_reg_to_dwarf)
#define okcrash_async_thread_state_mcontext_init OKNS(okcrash_async_thread_state_mcontext_init)
#define okcrash_async_thread_state_set_reg OKNS(okcrash_async_thread_state_set_reg)
#define okcrash_async_writen OKNS(okcrash_async_writen)
#define okcrash_log_writer_close OKNS(okcrash_log_writer_close)
#define okcrash_log_writer_free OKNS(okcrash_log_writer_free)
#define okcrash_log_writer_init OKNS(okcrash_log_writer_init)
#define okcrash_log_writer_set_exception OKNS(okcrash_log_writer_set_exception)
#define okcrash_log_writer_write OKNS(okcrash_log_writer_write)
#define okcrash_log_writer_set_custom_data OKNS(okcrash_log_writer_set_custom_data)
#define okcrash_nasync_image_list_append OKNS(okcrash_nasync_image_list_append)
#define okcrash_nasync_image_list_free OKNS(okcrash_nasync_image_list_free)
#define okcrash_nasync_image_list_init OKNS(okcrash_nasync_image_list_init)
#define okcrash_nasync_image_list_remove OKNS(okcrash_nasync_image_list_remove)
#define okcrash_nasync_macho_free OKNS(okcrash_nasync_macho_free)
#define okcrash_nasync_macho_init OKNS(okcrash_nasync_macho_init)
#define okcrash_populate_error OKNS(okcrash_populate_error)
#define okcrash_populate_mach_error OKNS(okcrash_populate_mach_error)
#define okcrash_populate_posix_error OKNS(okcrash_populate_posix_error)
#define okcrash_signal_handler OKNS(okcrash_signal_handler)
#define okcrash_sysctl_int OKNS(okcrash_sysctl_int)
#define okcrash_sysctl_string OKNS(okcrash_sysctl_string)
#define okcrash_sysctl_valid_utf8_bytes OKNS(okcrash_sysctl_valid_utf8_bytes)
#define okcrash_sysctl_valid_utf8_bytes_max OKNS(okcrash_sysctl_valid_utf8_bytes_max)
#define okcrash_writer_pack OKNS(okcrash_writer_pack)
#define okframe_cursor_free OKNS(okframe_cursor_free)
#define okframe_cursor_get_reg OKNS(okframe_cursor_get_reg)
#define okframe_cursor_get_regcount OKNS(okframe_cursor_get_regcount)
#define okframe_cursor_get_regname OKNS(okframe_cursor_get_regname)
#define okframe_cursor_init OKNS(okframe_cursor_init)
#define okframe_cursor_next OKNS(okframe_cursor_next)
#define okframe_cursor_next_with_readers OKNS(okframe_cursor_next_with_readers)
#define okframe_cursor_read_compact_unwind OKNS(okframe_cursor_read_compact_unwind)
#define okframe_cursor_read_dwarf_unwind OKNS(okframe_cursor_read_dwarf_unwind)
#define okframe_cursor_read_frame_ptr OKNS(okframe_cursor_read_frame_ptr)
#define okframe_cursor_thread_init OKNS(okframe_cursor_thread_init)
#define okframe_strerror OKNS(okframe_strerror)

#endif

/*
 * The following symbols are exported by the protobuf-c library. When building
 * a shared library, we can hide these as private symbols.
 *
 * However, when building a static library, we can only do so if we use
 * MH_OBJECT "single object prelink". The MH_OBJECT approach allows us to apply
 * symbol hiding/aliasing/etc similar to that supported by dylibs, but because it is
 * seemingly unused within Apple, the use thereof regularly introduces linking bugs
 * and errors in new Xcode releases.
 *
 * Rather than fighting the linker, we use the namespacing machinery to rewrite these
 * symbols, but only when explicitly compiling OKCrashReporter. Since protobuf-c is a library
 * that may be used elsewhere, we don't want to rewrite these symbols if they're used
 * independently by OKCrashReporter API clients.
 */
#ifdef OKCR_PRIVATE
   /* If no prefix has been defined, we need to specify our own private prefix */
#  ifndef OKCRASHREPORTER_PREFIX
#    define OKCRASHREPORTER_PREFIX OK_
#  endif

#  define oktracer_protobuf_c_buffer_simple_append                   OKNS(oktracer_protobuf_c_buffer_simple_append)
#  define oktracer_protobuf_c_empty_string                           OKNS(oktracer_protobuf_c_empty_string)
#  define oktracer_protobuf_c_enum_descriptor_get_value              OKNS(oktracer_protobuf_c_enum_descriptor_get_value)
#  define oktracer_protobuf_c_enum_descriptor_get_value_by_name      OKNS(oktracer_protobuf_c_enum_descriptor_get_value_by_name)
#  define oktracer_protobuf_c_message_check                          OKNS(oktracer_protobuf_c_message_check)
#  define oktracer_protobuf_c_message_descriptor_get_field           OKNS(oktracer_protobuf_c_message_descriptor_get_field)
#  define oktracer_protobuf_c_message_descriptor_get_field_by_name   OKNS(oktracer_protobuf_c_message_descriptor_get_field_by_name)
#  define oktracer_protobuf_c_message_free_unpacked                  OKNS(oktracer_protobuf_c_message_free_unpacked)
#  define oktracer_protobuf_c_message_get_packed_size                OKNS(oktracer_protobuf_c_message_get_packed_size)
#  define oktracer_protobuf_c_message_init                           OKNS(oktracer_protobuf_c_message_init)
#  define oktracer_protobuf_c_message_pack                           OKNS(oktracer_protobuf_c_message_pack)
#  define oktracer_protobuf_c_message_pack_to_buffer                 OKNS(oktracer_protobuf_c_message_pack_to_buffer)
#  define oktracer_protobuf_c_message_unpack                         OKNS(oktracer_protobuf_c_message_unpack)
#  define oktracer_protobuf_c_service_descriptor_get_method_by_name  OKNS(oktracer_protobuf_c_service_descriptor_get_method_by_name)
#  define oktracer_protobuf_c_service_destroy                        OKNS(oktracer_protobuf_c_service_destroy)
#  define oktracer_protobuf_c_service_generated_init                 OKNS(oktracer_protobuf_c_service_generated_init)
#  define oktracer_protobuf_c_service_invoke_internal                OKNS(oktracer_protobuf_c_service_invoke_internal)
#  define oktracer_protobuf_c_version                                OKNS(oktracer_protobuf_c_version)
#  define oktracer_protobuf_c_version_number                         OKNS(oktracer_protobuf_c_version_number)
#endif /* OKCR_PRIVATE */
