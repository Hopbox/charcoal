# This Makefile is for the Charcoal extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.98 (Revision: 69800) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Catalyst based application]
#     AUTHOR => [q[Nishant Sharma,,,]]
#     BUILD_REQUIRES => { Test::More=>q[0.88], ExtUtils::MakeMaker=>q[6.36] }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[Charcoal]
#     EXE_FILES => [q[script/charcoal_cgi.pl], q[script/charcoal_create.pl], q[script/charcoal_fastcgi.pl], q[script/charcoal_server.pl], q[script/charcoal_test.pl]]
#     LICENSE => q[perl]
#     NAME => q[Charcoal]
#     NO_META => q[1]
#     PREREQ_PM => { Catalyst::Action::RenderView=>q[0], namespace::autoclean=>q[0], Moose=>q[0], Starman=>q[0], Catalyst::Plugin::Authentication=>q[0], ExtUtils::MakeMaker=>q[6.36], Catalyst::Plugin::Session::Store::Memcached::Fast=>q[0], Test::More=>q[0.88], Catalyst::Plugin::Static::Simple=>q[0], Catalyst::Plugin::Cache::FastMmap=>q[0], Catalyst::Runtime=>q[5.90079], Catalyst::Plugin::ConfigLoader=>q[0], Data::Validate::IP=>q[0], JSON::XS=>q[0], Plack=>q[0], Config::General=>q[0], Catalyst::Plugin::Session::State::Cookie=>q[0] }
#     TEST_REQUIRES => {  }
#     VERSION => q[0.03]
#     VERSION_FROM => q[lib/Charcoal.pm]
#     dist => {  }
#     realclean => { FILES=>q[MYMETA.yml] }
#     test => { TESTS=>q[t/01app.t t/02pod.t t/03podcoverage.t t/controller_Admin-Acls.t t/controller_Admin-Destinations.t t/controller_Admin-SourceGroups.t t/controller_Admin-Sources.t t/controller_Admin.t t/controller_Login.t t/controller_Logout.t t/model_Mongo.t t/model_Pg.t t/model_PgDB.t t/view_HTML.t t/view_JSON.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/arm-linux-gnueabihf/perl/5.20/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = libc-2.19.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 3.19.0-trunk-armmp
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.20.2
SITEARCHEXP = /usr/local/lib/arm-linux-gnueabihf/perl/5.20.2
SO = so
VENDORARCHEXP = /usr/lib/arm-linux-gnueabihf/perl5/5.20
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Charcoal
NAME_SYM = Charcoal
VERSION = 0.03
VERSION_MACRO = VERSION
VERSION_SYM = 0_03
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.03
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = /usr
PERLPREFIX = $(PREFIX)
SITEPREFIX = $(PREFIX)/local
VENDORPREFIX = $(PREFIX)
INSTALLPRIVLIB = $(PERLPREFIX)/share/perl/5.20
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.20.2
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(VENDORPREFIX)/share/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(PERLPREFIX)/lib/arm-linux-gnueabihf/perl/5.20
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(SITEPREFIX)/lib/arm-linux-gnueabihf/perl/5.20.2
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(VENDORPREFIX)/lib/arm-linux-gnueabihf/perl5/5.20
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(PERLPREFIX)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(SITEPREFIX)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(VENDORPREFIX)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(PERLPREFIX)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(SITEPREFIX)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(VENDORPREFIX)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(PERLPREFIX)/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(SITEPREFIX)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(VENDORPREFIX)/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(PERLPREFIX)/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(SITEPREFIX)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(VENDORPREFIX)/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /usr/lib/arm-linux-gnueabihf/perl/5.20
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/arm-linux-gnueabihf/perl/5.20/CORE
PERL = /usr/bin/perl "-Iinc"
FULLPERL = /usr/bin/perl "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.20/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.98
MM_REVISION = 69800

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Charcoal
BASEEXT = Charcoal
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Charcoal.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/charcoal_cgi.pl \
	script/charcoal_create.pl \
	script/charcoal_fastcgi.pl \
	script/charcoal_server.pl \
	script/charcoal_test.pl
MAN3PODS = lib/Charcoal.pm \
	lib/Charcoal/Controller/Admin.pm \
	lib/Charcoal/Controller/Admin/Acls.pm \
	lib/Charcoal/Controller/Admin/Destinations.pm \
	lib/Charcoal/Controller/Admin/SourceGroups.pm \
	lib/Charcoal/Controller/Admin/Sources.pm \
	lib/Charcoal/Controller/Login.pm \
	lib/Charcoal/Controller/Logout.pm \
	lib/Charcoal/Controller/Root.pm \
	lib/Charcoal/Model/PgDB.pm \
	lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	lib/Charcoal/Schema/PgDB/Result/Category.pm \
	lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/Group.pm \
	lib/Charcoal/Schema/PgDB/Result/Src.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	lib/Charcoal/Schema/PgDB/Result/Url.pm \
	lib/Charcoal/Schema/PgDB/Result/User.pm \
	lib/Charcoal/View/HTML.pm \
	lib/Charcoal/View/JSON.pm \
	lib/PgDB/Schema/Result/Acl.pm \
	lib/PgDB/Schema/Result/CDomCat.pm \
	lib/PgDB/Schema/Result/CDomain.pm \
	lib/PgDB/Schema/Result/Category.pm \
	lib/PgDB/Schema/Result/Customer.pm \
	lib/PgDB/Schema/Result/Domain.pm \
	lib/PgDB/Schema/Result/Expr.pm \
	lib/PgDB/Schema/Result/GlDomCat.pm \
	lib/PgDB/Schema/Result/Group.pm \
	lib/PgDB/Schema/Result/Src.pm \
	lib/PgDB/Schema/Result/SrcGroup.pm \
	lib/PgDB/Schema/Result/SrcType.pm \
	lib/PgDB/Schema/Result/Url.pm \
	lib/PgDB/Schema/Result/User.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/Charcoal.pm \
	lib/Charcoal/Controller/Admin.pm \
	lib/Charcoal/Controller/Admin/Acls.pm \
	lib/Charcoal/Controller/Admin/Destinations.pm \
	lib/Charcoal/Controller/Admin/SourceGroups.pm \
	lib/Charcoal/Controller/Admin/Sources.pm \
	lib/Charcoal/Controller/Login.pm \
	lib/Charcoal/Controller/Logout.pm \
	lib/Charcoal/Controller/Root.pm \
	lib/Charcoal/Model/PgDB.pm \
	lib/Charcoal/Model/PgDB.pm.back \
	lib/Charcoal/Schema/PgDB.pm \
	lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	lib/Charcoal/Schema/PgDB/Result/Category.pm \
	lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/Group.pm \
	lib/Charcoal/Schema/PgDB/Result/Src.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	lib/Charcoal/Schema/PgDB/Result/Url.pm \
	lib/Charcoal/Schema/PgDB/Result/User.pm \
	lib/Charcoal/View/HTML.pm \
	lib/Charcoal/View/JSON.pm \
	lib/PgDB/Schema.pm \
	lib/PgDB/Schema/Result/Acl.pm \
	lib/PgDB/Schema/Result/CDomCat.pm \
	lib/PgDB/Schema/Result/CDomain.pm \
	lib/PgDB/Schema/Result/Category.pm \
	lib/PgDB/Schema/Result/Customer.pm \
	lib/PgDB/Schema/Result/Domain.pm \
	lib/PgDB/Schema/Result/Expr.pm \
	lib/PgDB/Schema/Result/GlDomCat.pm \
	lib/PgDB/Schema/Result/Group.pm \
	lib/PgDB/Schema/Result/Src.pm \
	lib/PgDB/Schema/Result/SrcGroup.pm \
	lib/PgDB/Schema/Result/SrcType.pm \
	lib/PgDB/Schema/Result/Url.pm \
	lib/PgDB/Schema/Result/User.pm

PM_TO_BLIB = lib/Charcoal.pm \
	blib/lib/Charcoal.pm \
	lib/Charcoal/Controller/Admin.pm \
	blib/lib/Charcoal/Controller/Admin.pm \
	lib/Charcoal/Controller/Admin/Acls.pm \
	blib/lib/Charcoal/Controller/Admin/Acls.pm \
	lib/Charcoal/Controller/Admin/Destinations.pm \
	blib/lib/Charcoal/Controller/Admin/Destinations.pm \
	lib/Charcoal/Controller/Admin/SourceGroups.pm \
	blib/lib/Charcoal/Controller/Admin/SourceGroups.pm \
	lib/Charcoal/Controller/Admin/Sources.pm \
	blib/lib/Charcoal/Controller/Admin/Sources.pm \
	lib/Charcoal/Controller/Login.pm \
	blib/lib/Charcoal/Controller/Login.pm \
	lib/Charcoal/Controller/Logout.pm \
	blib/lib/Charcoal/Controller/Logout.pm \
	lib/Charcoal/Controller/Root.pm \
	blib/lib/Charcoal/Controller/Root.pm \
	lib/Charcoal/Model/PgDB.pm \
	blib/lib/Charcoal/Model/PgDB.pm \
	lib/Charcoal/Model/PgDB.pm.back \
	blib/lib/Charcoal/Model/PgDB.pm.back \
	lib/Charcoal/Schema/PgDB.pm \
	blib/lib/Charcoal/Schema/PgDB.pm \
	lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	lib/Charcoal/Schema/PgDB/Result/Category.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Category.pm \
	lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/Group.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Group.pm \
	lib/Charcoal/Schema/PgDB/Result/Src.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Src.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	lib/Charcoal/Schema/PgDB/Result/Url.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/Url.pm \
	lib/Charcoal/Schema/PgDB/Result/User.pm \
	blib/lib/Charcoal/Schema/PgDB/Result/User.pm \
	lib/Charcoal/View/HTML.pm \
	blib/lib/Charcoal/View/HTML.pm \
	lib/Charcoal/View/JSON.pm \
	blib/lib/Charcoal/View/JSON.pm \
	lib/PgDB/Schema.pm \
	blib/lib/PgDB/Schema.pm \
	lib/PgDB/Schema/Result/Acl.pm \
	blib/lib/PgDB/Schema/Result/Acl.pm \
	lib/PgDB/Schema/Result/CDomCat.pm \
	blib/lib/PgDB/Schema/Result/CDomCat.pm \
	lib/PgDB/Schema/Result/CDomain.pm \
	blib/lib/PgDB/Schema/Result/CDomain.pm \
	lib/PgDB/Schema/Result/Category.pm \
	blib/lib/PgDB/Schema/Result/Category.pm \
	lib/PgDB/Schema/Result/Customer.pm \
	blib/lib/PgDB/Schema/Result/Customer.pm \
	lib/PgDB/Schema/Result/Domain.pm \
	blib/lib/PgDB/Schema/Result/Domain.pm \
	lib/PgDB/Schema/Result/Expr.pm \
	blib/lib/PgDB/Schema/Result/Expr.pm \
	lib/PgDB/Schema/Result/GlDomCat.pm \
	blib/lib/PgDB/Schema/Result/GlDomCat.pm \
	lib/PgDB/Schema/Result/Group.pm \
	blib/lib/PgDB/Schema/Result/Group.pm \
	lib/PgDB/Schema/Result/Src.pm \
	blib/lib/PgDB/Schema/Result/Src.pm \
	lib/PgDB/Schema/Result/SrcGroup.pm \
	blib/lib/PgDB/Schema/Result/SrcGroup.pm \
	lib/PgDB/Schema/Result/SrcType.pm \
	blib/lib/PgDB/Schema/Result/SrcType.pm \
	lib/PgDB/Schema/Result/Url.pm \
	blib/lib/PgDB/Schema/Result/Url.pm \
	lib/PgDB/Schema/Result/User.pm \
	blib/lib/PgDB/Schema/Result/User.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.98
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --
CP_NONEMPTY = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'cp_nonempty' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Charcoal
DISTVNAME = Charcoal-0.03


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	LD="$(LD)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(BOOTSTRAP) $(INST_DYNAMIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	lib/Charcoal.pm \
	lib/Charcoal/Controller/Admin.pm \
	lib/Charcoal/Controller/Admin/Acls.pm \
	lib/Charcoal/Controller/Admin/Destinations.pm \
	lib/Charcoal/Controller/Admin/SourceGroups.pm \
	lib/Charcoal/Controller/Admin/Sources.pm \
	lib/Charcoal/Controller/Login.pm \
	lib/Charcoal/Controller/Logout.pm \
	lib/Charcoal/Controller/Root.pm \
	lib/Charcoal/Model/PgDB.pm \
	lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	lib/Charcoal/Schema/PgDB/Result/Category.pm \
	lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	lib/Charcoal/Schema/PgDB/Result/Group.pm \
	lib/Charcoal/Schema/PgDB/Result/Src.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	lib/Charcoal/Schema/PgDB/Result/Url.pm \
	lib/Charcoal/Schema/PgDB/Result/User.pm \
	lib/Charcoal/View/HTML.pm \
	lib/Charcoal/View/JSON.pm \
	lib/PgDB/Schema/Result/Acl.pm \
	lib/PgDB/Schema/Result/CDomCat.pm \
	lib/PgDB/Schema/Result/CDomain.pm \
	lib/PgDB/Schema/Result/Category.pm \
	lib/PgDB/Schema/Result/Customer.pm \
	lib/PgDB/Schema/Result/Domain.pm \
	lib/PgDB/Schema/Result/Expr.pm \
	lib/PgDB/Schema/Result/GlDomCat.pm \
	lib/PgDB/Schema/Result/Group.pm \
	lib/PgDB/Schema/Result/Src.pm \
	lib/PgDB/Schema/Result/SrcGroup.pm \
	lib/PgDB/Schema/Result/SrcType.pm \
	lib/PgDB/Schema/Result/Url.pm \
	lib/PgDB/Schema/Result/User.pm \
	script/charcoal_cgi.pl \
	script/charcoal_create.pl \
	script/charcoal_fastcgi.pl \
	script/charcoal_server.pl \
	script/charcoal_test.pl
	$(NOECHO) $(POD2MAN) --section=$(MAN1EXT) --perm_rw=$(PERM_RW) \
	  script/charcoal_cgi.pl $(INST_MAN1DIR)/charcoal_cgi.pl.$(MAN1EXT) \
	  script/charcoal_create.pl $(INST_MAN1DIR)/charcoal_create.pl.$(MAN1EXT) \
	  script/charcoal_fastcgi.pl $(INST_MAN1DIR)/charcoal_fastcgi.pl.$(MAN1EXT) \
	  script/charcoal_server.pl $(INST_MAN1DIR)/charcoal_server.pl.$(MAN1EXT) \
	  script/charcoal_test.pl $(INST_MAN1DIR)/charcoal_test.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/Charcoal.pm $(INST_MAN3DIR)/Charcoal.$(MAN3EXT) \
	  lib/Charcoal/Controller/Admin.pm $(INST_MAN3DIR)/Charcoal::Controller::Admin.$(MAN3EXT) \
	  lib/Charcoal/Controller/Admin/Acls.pm $(INST_MAN3DIR)/Charcoal::Controller::Admin::Acls.$(MAN3EXT) \
	  lib/Charcoal/Controller/Admin/Destinations.pm $(INST_MAN3DIR)/Charcoal::Controller::Admin::Destinations.$(MAN3EXT) \
	  lib/Charcoal/Controller/Admin/SourceGroups.pm $(INST_MAN3DIR)/Charcoal::Controller::Admin::SourceGroups.$(MAN3EXT) \
	  lib/Charcoal/Controller/Admin/Sources.pm $(INST_MAN3DIR)/Charcoal::Controller::Admin::Sources.$(MAN3EXT) \
	  lib/Charcoal/Controller/Login.pm $(INST_MAN3DIR)/Charcoal::Controller::Login.$(MAN3EXT) \
	  lib/Charcoal/Controller/Logout.pm $(INST_MAN3DIR)/Charcoal::Controller::Logout.$(MAN3EXT) \
	  lib/Charcoal/Controller/Root.pm $(INST_MAN3DIR)/Charcoal::Controller::Root.$(MAN3EXT) \
	  lib/Charcoal/Model/PgDB.pm $(INST_MAN3DIR)/Charcoal::Model::PgDB.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Acl.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Acl.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/CDomCat.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::CDomCat.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/CDomain.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::CDomain.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Category.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Category.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Customer.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Customer.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Domain.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Domain.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Expr.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Expr.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::GlDomCat.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Group.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Group.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Src.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Src.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::SrcGroup.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/SrcType.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::SrcType.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/Url.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::Url.$(MAN3EXT) \
	  lib/Charcoal/Schema/PgDB/Result/User.pm $(INST_MAN3DIR)/Charcoal::Schema::PgDB::Result::User.$(MAN3EXT) \
	  lib/Charcoal/View/HTML.pm $(INST_MAN3DIR)/Charcoal::View::HTML.$(MAN3EXT) \
	  lib/Charcoal/View/JSON.pm $(INST_MAN3DIR)/Charcoal::View::JSON.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Acl.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Acl.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/PgDB/Schema/Result/CDomCat.pm $(INST_MAN3DIR)/PgDB::Schema::Result::CDomCat.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/CDomain.pm $(INST_MAN3DIR)/PgDB::Schema::Result::CDomain.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Category.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Category.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Customer.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Customer.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Domain.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Domain.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Expr.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Expr.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/GlDomCat.pm $(INST_MAN3DIR)/PgDB::Schema::Result::GlDomCat.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Group.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Group.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Src.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Src.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/SrcGroup.pm $(INST_MAN3DIR)/PgDB::Schema::Result::SrcGroup.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/SrcType.pm $(INST_MAN3DIR)/PgDB::Schema::Result::SrcType.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/Url.pm $(INST_MAN3DIR)/PgDB::Schema::Result::Url.$(MAN3EXT) \
	  lib/PgDB/Schema/Result/User.pm $(INST_MAN3DIR)/PgDB::Schema::Result::User.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/charcoal_cgi.pl script/charcoal_create.pl script/charcoal_fastcgi.pl script/charcoal_server.pl script/charcoal_test.pl

pure_all :: $(INST_SCRIPT)/charcoal_cgi.pl $(INST_SCRIPT)/charcoal_test.pl $(INST_SCRIPT)/charcoal_server.pl $(INST_SCRIPT)/charcoal_create.pl $(INST_SCRIPT)/charcoal_fastcgi.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/charcoal_cgi.pl $(INST_SCRIPT)/charcoal_test.pl \
	  $(INST_SCRIPT)/charcoal_server.pl $(INST_SCRIPT)/charcoal_create.pl \
	  $(INST_SCRIPT)/charcoal_fastcgi.pl 

$(INST_SCRIPT)/charcoal_cgi.pl : script/charcoal_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/charcoal_cgi.pl
	$(CP) script/charcoal_cgi.pl $(INST_SCRIPT)/charcoal_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/charcoal_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/charcoal_cgi.pl

$(INST_SCRIPT)/charcoal_test.pl : script/charcoal_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/charcoal_test.pl
	$(CP) script/charcoal_test.pl $(INST_SCRIPT)/charcoal_test.pl
	$(FIXIN) $(INST_SCRIPT)/charcoal_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/charcoal_test.pl

$(INST_SCRIPT)/charcoal_server.pl : script/charcoal_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/charcoal_server.pl
	$(CP) script/charcoal_server.pl $(INST_SCRIPT)/charcoal_server.pl
	$(FIXIN) $(INST_SCRIPT)/charcoal_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/charcoal_server.pl

$(INST_SCRIPT)/charcoal_create.pl : script/charcoal_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/charcoal_create.pl
	$(CP) script/charcoal_create.pl $(INST_SCRIPT)/charcoal_create.pl
	$(FIXIN) $(INST_SCRIPT)/charcoal_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/charcoal_create.pl

$(INST_SCRIPT)/charcoal_fastcgi.pl : script/charcoal_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/charcoal_fastcgi.pl
	$(CP) script/charcoal_fastcgi.pl $(INST_SCRIPT)/charcoal_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/charcoal_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/charcoal_fastcgi.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  $(BASEEXT).bso $(BASEEXT).def \
	  $(BASEEXT).exp $(BASEEXT).x \
	  $(BOOTSTRAP) $(INST_ARCHAUTODIR)/extralibs.all \
	  $(INST_ARCHAUTODIR)/extralibs.ld $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) *$(OBJ_EXT) \
	  *perl.core MYMETA.json \
	  MYMETA.yml blibdirs.ts \
	  core core.*perl.*.? \
	  core.[0-9] core.[0-9][0-9] \
	  core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] \
	  core.[0-9][0-9][0-9][0-9][0-9] lib$(BASEEXT).def \
	  mon.out perl \
	  perl$(EXE_EXT) perl.exe \
	  perlmain.c pm_to_blib \
	  pm_to_blib.ts so_locations \
	  tmon.out 
	- $(RM_RF) \
	  blib 
	  $(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(FIRST_MAKEFILE) $(MAKEFILE_OLD) 
	- $(RM_RF) \
	  MYMETA.yml $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)_uu'

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)'
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).zip'
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).shar'
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.yml to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.json to MANIFEST: $$$${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)


doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLSITEARCH)/perllocal.pod
	-$(NOECHO) umask 02; $(MKPATH) $(DESTINSTALLSITEARCH)
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLSITEARCH)/perllocal.pod

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::



# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/01app.t t/02pod.t t/03podcoverage.t t/controller_Admin-Acls.t t/controller_Admin-Destinations.t t/controller_Admin-SourceGroups.t t/controller_Admin-Sources.t t/controller_Admin.t t/controller_Login.t t/controller_Logout.t t/model_Mongo.t t/model_Pg.t t/model_PgDB.t t/view_HTML.t t/view_JSON.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="$(VERSION)">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Catalyst based application</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Nishant Sharma,,,</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Action::RenderView" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authentication" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Cache::FastMmap" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::ConfigLoader" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::State::Cookie" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::Store::Memcached::Fast" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Static::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Runtime" VERSION="5.90079" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::General" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Validate::IP" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="JSON::XS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Moose::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Plack::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Starman::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="namespace::autoclean" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="arm-linux-gnueabihf-thread-multi-64int-5.20" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/Charcoal.pm blib/lib/Charcoal.pm \
	  lib/Charcoal/Controller/Admin.pm blib/lib/Charcoal/Controller/Admin.pm \
	  lib/Charcoal/Controller/Admin/Acls.pm blib/lib/Charcoal/Controller/Admin/Acls.pm \
	  lib/Charcoal/Controller/Admin/Destinations.pm blib/lib/Charcoal/Controller/Admin/Destinations.pm \
	  lib/Charcoal/Controller/Admin/SourceGroups.pm blib/lib/Charcoal/Controller/Admin/SourceGroups.pm \
	  lib/Charcoal/Controller/Admin/Sources.pm blib/lib/Charcoal/Controller/Admin/Sources.pm \
	  lib/Charcoal/Controller/Login.pm blib/lib/Charcoal/Controller/Login.pm \
	  lib/Charcoal/Controller/Logout.pm blib/lib/Charcoal/Controller/Logout.pm \
	  lib/Charcoal/Controller/Root.pm blib/lib/Charcoal/Controller/Root.pm \
	  lib/Charcoal/Model/PgDB.pm blib/lib/Charcoal/Model/PgDB.pm \
	  lib/Charcoal/Model/PgDB.pm.back blib/lib/Charcoal/Model/PgDB.pm.back \
	  lib/Charcoal/Schema/PgDB.pm blib/lib/Charcoal/Schema/PgDB.pm \
	  lib/Charcoal/Schema/PgDB/Result/Acl.pm blib/lib/Charcoal/Schema/PgDB/Result/Acl.pm \
	  lib/Charcoal/Schema/PgDB/Result/CDomCat.pm blib/lib/Charcoal/Schema/PgDB/Result/CDomCat.pm \
	  lib/Charcoal/Schema/PgDB/Result/CDomain.pm blib/lib/Charcoal/Schema/PgDB/Result/CDomain.pm \
	  lib/Charcoal/Schema/PgDB/Result/Category.pm blib/lib/Charcoal/Schema/PgDB/Result/Category.pm \
	  lib/Charcoal/Schema/PgDB/Result/Customer.pm blib/lib/Charcoal/Schema/PgDB/Result/Customer.pm \
	  lib/Charcoal/Schema/PgDB/Result/Domain.pm blib/lib/Charcoal/Schema/PgDB/Result/Domain.pm \
	  lib/Charcoal/Schema/PgDB/Result/Expr.pm blib/lib/Charcoal/Schema/PgDB/Result/Expr.pm \
	  lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm blib/lib/Charcoal/Schema/PgDB/Result/GlDomCat.pm \
	  lib/Charcoal/Schema/PgDB/Result/Group.pm blib/lib/Charcoal/Schema/PgDB/Result/Group.pm \
	  lib/Charcoal/Schema/PgDB/Result/Src.pm blib/lib/Charcoal/Schema/PgDB/Result/Src.pm \
	  lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm blib/lib/Charcoal/Schema/PgDB/Result/SrcGroup.pm \
	  lib/Charcoal/Schema/PgDB/Result/SrcType.pm blib/lib/Charcoal/Schema/PgDB/Result/SrcType.pm \
	  lib/Charcoal/Schema/PgDB/Result/Url.pm blib/lib/Charcoal/Schema/PgDB/Result/Url.pm \
	  lib/Charcoal/Schema/PgDB/Result/User.pm blib/lib/Charcoal/Schema/PgDB/Result/User.pm \
	  lib/Charcoal/View/HTML.pm blib/lib/Charcoal/View/HTML.pm \
	  lib/Charcoal/View/JSON.pm blib/lib/Charcoal/View/JSON.pm \
	  lib/PgDB/Schema.pm blib/lib/PgDB/Schema.pm \
	  lib/PgDB/Schema/Result/Acl.pm blib/lib/PgDB/Schema/Result/Acl.pm \
	  lib/PgDB/Schema/Result/CDomCat.pm blib/lib/PgDB/Schema/Result/CDomCat.pm \
	  lib/PgDB/Schema/Result/CDomain.pm blib/lib/PgDB/Schema/Result/CDomain.pm \
	  lib/PgDB/Schema/Result/Category.pm blib/lib/PgDB/Schema/Result/Category.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/PgDB/Schema/Result/Customer.pm blib/lib/PgDB/Schema/Result/Customer.pm \
	  lib/PgDB/Schema/Result/Domain.pm blib/lib/PgDB/Schema/Result/Domain.pm \
	  lib/PgDB/Schema/Result/Expr.pm blib/lib/PgDB/Schema/Result/Expr.pm \
	  lib/PgDB/Schema/Result/GlDomCat.pm blib/lib/PgDB/Schema/Result/GlDomCat.pm \
	  lib/PgDB/Schema/Result/Group.pm blib/lib/PgDB/Schema/Result/Group.pm \
	  lib/PgDB/Schema/Result/Src.pm blib/lib/PgDB/Schema/Result/Src.pm \
	  lib/PgDB/Schema/Result/SrcGroup.pm blib/lib/PgDB/Schema/Result/SrcGroup.pm \
	  lib/PgDB/Schema/Result/SrcType.pm blib/lib/PgDB/Schema/Result/SrcType.pm \
	  lib/PgDB/Schema/Result/Url.pm blib/lib/PgDB/Schema/Result/Url.pm \
	  lib/PgDB/Schema/Result/User.pm blib/lib/PgDB/Schema/Result/User.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 1.14
# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(PERL) Makefile.PL --config= --installdeps=Catalyst::Runtime,5.90079,Catalyst::Plugin::Session::Store::Memcached::Fast,0

installdeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --installdeps=Catalyst::Runtime,5.90079,Catalyst::Plugin::Session::Store::Memcached::Fast,0

upgradedeps ::
	$(PERL) Makefile.PL --config= --upgradedeps=Catalyst::Runtime,5.90079,Catalyst::Plugin::Session::Store::Memcached::Fast,0,Test::More,0.88,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Plugin::Cache::FastMmap,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Session::State::Cookie,0,Moose,0,namespace::autoclean,0,Config::General,0,Plack,0,Starman,0,JSON::XS,0,Data::Validate::IP,0

upgradedeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --upgradedeps=Catalyst::Runtime,5.90079,Catalyst::Plugin::Session::Store::Memcached::Fast,0,Test::More,0.88,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Plugin::Cache::FastMmap,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Session::State::Cookie,0,Moose,0,namespace::autoclean,0,Config::General,0,Plack,0,Starman,0,JSON::XS,0,Data::Validate::IP,0

listdeps ::
	@$(PERL) -le "print for @ARGV" Catalyst::Runtime Catalyst::Plugin::Session::Store::Memcached::Fast

listalldeps ::
	@$(PERL) -le "print for @ARGV" Catalyst::Runtime Catalyst::Plugin::Session::Store::Memcached::Fast Test::More Catalyst::Plugin::ConfigLoader Catalyst::Plugin::Static::Simple Catalyst::Action::RenderView Catalyst::Plugin::Cache::FastMmap Catalyst::Plugin::Authentication Catalyst::Plugin::Session::State::Cookie Moose namespace::autoclean Config::General Plack Starman JSON::XS Data::Validate::IP

