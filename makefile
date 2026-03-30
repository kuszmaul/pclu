# makefile for Portable CLU

# The original makefile is in `Makefile`.  This one is is preferred by gnu make
# because it looks for `makefile` before `Makefile`.  This one is a single
# makefile that understands all thd dependencies.

CFLAGS=-Wno-builtin-declaration-mismatch
CPPFLAGS=-Icode/include

LIBCLU_RAW_OS = _all_file_names_.o _int_range.o _job_stuff.o _longsub.o _qindexc.o \
        _resolve.o _signal_type.o _system_root.o _time_format.o _unquote.o \
        all_file_names.o array_replace.o bigint.o cos.o \
        delete_expunge.o dparse.o gc_copy.o gc_dump.o gc_read.o gcd_tab.o \
        heap.o hex.o host_address.o inet_address.o isqrt.o istream.o \
        lex_scan.o maybe.o octal.o open_append.o open_read.o open_write.o os.o \
        parse_line.o pstream.o quick_sort.o quicksort.o run_time.o scase.o \
        split_line.o strim.o string_lindexs.o string_ops.o table.o tan.o \
        time.o unify_spacing.o xref.o
LIBCLU_OPT = $(patsubst %, stage1/libclu/%, $(LIBCLU_RAW_OS))
# /{libclu,sysclu,libasm,sysasm}/Opt/*.o
stage1/libpclu_opt.a: $(LIBCLU_OPT) | stage1/libclu
	$(AR) cr $@ $?
$(LIBCLU_OPT) : code/include/pclu_err.h code/include/pclu_sys.h | stage1/libclu/
stage1/libclu/%.o: code/libclu/Opt/%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
%/:
	mkdir -p $@
