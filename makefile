# makefile for Portable CLU

# The original makefile is in `Makefile`.  This one is is preferred by gnu make
# because it looks for `makefile` before `Makefile`.  This one is a single
# makefile that understands all thd dependencies.

stage1: stage1/cmp/pclu

CFLAGS=-Wno-builtin-declaration-mismatch -O2 -g
CPPFLAGS=-Icode/include -DLINUX

LIBCLU_OS = _all_file_names_.o _int_range.o _job_stuff.o _longsub.o _qindexc.o \
        _resolve.o _signal_type.o _system_root.o _time_format.o _unquote.o \
        all_file_names.o array_replace.o bigint.o cos.o \
        delete_expunge.o dparse.o gc_copy.o gc_dump.o gc_read.o gcd_tab.o \
        heap.o hex.o host_address.o inet_address.o isqrt.o istream.o \
        lex_scan.o maybe.o octal.o open_append.o open_read.o open_write.o os.o \
        parse_line.o pstream.o quick_sort.o quicksort.o run_time.o scase.o \
        split_line.o strim.o string_lindexs.o string_ops.o table.o tan.o \
        time.o unify_spacing.o xref.o
SYSCLU_OS = _cause_bounds.o _cause_illegal_char.o _cause_overflow.o \
        _cause_wrong_tag.o _cause_wrong_type.o _cleanup_.o _dir_ent_size.o \
        _erstr.o _fixup_dir_part.o _fixup_file_name.o _get_termcap.o \
        _home_dir.o _last_indexc.o _skip_fill.o _split_name_part.o \
        _termcap.o _termcap_entry.o _working_dir.o date.o e_form.o f_form.o \
        file_name.o file_name_fill.o file_spec.o g_form.o set_working_dir.o \
        stream.o user_name.o working_dir.o
LIBASM_OS = _all_dir_entries_.o _byteptr.o _byteptr8.o _change_mode.o \
        _change_owner.o _change_signal.o _dtable_size.o _exit.o _file_access.o \
        _file_exists.o _file_facts.o _file_owner.o _get_gid.o \
        _get_pname.o _get_priority.o _get_runtime.o _get_uid.o _get_version.o \
        _get_xjname.o _groups.o _heap_size.o _host_address.o _host_id.o \
        _host_name.o _ioctl.o  _lstat.o _micro_time.o _nice.o _obj.o \
        _page_size.o _pause.o _read_link.o _real_time.o _rusage.o _select.o \
        _set_alarm.o _set_limit.o _set_priority.o _signal.o _sleep.o _stat.o \
        _stop.o _type_base.o _umask.o _wordvec.o create_directory.o \
        delete_directory.o file_date.o file_exists.o gc.o get_argv.o get_env.o \
        get_jcl.o hash.o hash_int.o hash_obj.o istream2chan.o link_file.o \
        mint.o pause.o quit_.o random.o set_connected_dir.o sleep.o \
        stream2chan.o symlink_file.o version.o _free_space.o \
	_get_active_heap.o _get_max_heap.o _set_max_heap.o _get_min_gc.o \
	_set_min_gc.o _cluref_size.o
SYSASM_OS = _adv.o _anyize.o _bytevec.o _chan.o _cvt.o _environ.o _environs.o \
	_event.o _get_pid.o _gprof.o _local_time.o _round_real.o _tagcell.o \
	_unparse_real.o _vec.o alloc.o array.o bool.o char.o connected_dir.o \
	delete_file.o force.o gprof.o int.o itertype.o log.o new_parm_util.o \
	new_selector.o now.o null.o oneof.o oneof_pfx.o proctype.o real.o \
	record.o record_pfx.o rename_file.o sequence.o string.o \
	struct.o struct_pfx.o type.o type_of.o unimp.o unix_cmd.o util.o \
	variant.o variant_pfx.o

LIBCLU_OPT = $(patsubst %, stage1/libclu/%, $(LIBCLU_OS))
SYSCLU_OPT = $(patsubst %, stage1/sysclu/%, $(SYSCLU_OS))
LIBASM_OPT = $(patsubst %, stage1/libasm/%, $(LIBASM_OS))
SYSASM_OPT = $(patsubst %, stage1/sysasm/%, $(SYSASM_OS))
O_OPT = $(LIBCLU_OPT) $(SYSCLU_OPT) $(LIBASM_OPT) $(SYSASM_OPT)
# /{libclu,sysclu,libasm,sysasm}/Opt/*.o
stage1/libpclu_opt.a: $(O_OPT) | stage1/libclu
	$(AR) cr $@ $?
$(O_OPT): code/include/pclu_err.h code/include/pclu_sys.h
stage1/libclu/%.o: code/libclu/Opt/%.c | stage1/libclu
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1/sysclu/%.o: code/sysclu/Opt/%.c | stage1/sysclu
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1/libasm/%.o: code/libasm/Opt/%.c | stage1/libasm
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1/sysasm/%.o: code/sysasm/Opt/%.c | stage1/sysasm
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1 stage1/libclu stage1/sysclu stage1/libasm stage1/sysasm stage1/cmp stage1/cmpasm:
	mkdir -p $@

CMP_BASE_OS = build.o cconst.o cdchan.o cdefn1.o cdefn2.o ce.o cenv.o \
	cexpr1.o cexpr2.o cmpvar.o coper.o cspecs.o cstmt1.o cstmt2.o \
	dtchan.o du.o eval1.o eval2.o gconst.o gdbg.o genv.o giter.o gparm.o \
	gdefn.o gstmt.o gtbl.o gexpr.o gopt1.o gtypes.o gutil.o gvars.o \
	idn.o init.o lineedit.o pconst.o pdefn1.o pdefn2.o penv.o \
	pexpr.o pjcl.o plist.o pstmt1.o pstmt2.o pttkn.o \
	stable.o syntax.o tkntab.o top1.o top2.o \
	vcmp.o xlib.o
CMPASM_BASE_OS = _bin_id.o _save_state.o _restore_state.o version.o
CMP_OS = $(patsubst %, stage1/cmp/%, $(CMP_BASE_OS)) $(patsubst %, stage1/cmpasm/%, $(CMPASM_BASE_OS))
stage1/cmp/%.o: code/cmp/%.c | stage1/cmp
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1/cmpasm/%.o: code/cmpasm/%.c | stage1/cmpasm
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
stage1/cmp/pclu: $(CMP_OS) stage1/libpclu_opt.a | stage1/cmp
	$(CC) -Lstage1 -Lcode $(CMP_OS) -o $@ -lpclu_opt -lm -lgc

clean:
	rm -rf stage1
