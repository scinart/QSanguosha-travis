PREFIX:=/usr/local
OLDPWD:=$(PWD)
BUILD:=$(PWD)/build
DEBUG_BUILD:=$(PWD)/debug_build

all: release

$(OLDPWD)/QSanguosha.pro:

swig/sanguosha_wrap.cxx: swig/ai.i swig/card.i swig/list.i swig/luaskills.i swig/native.i swig/naturalvar.i swig/qvariant.i swig/sanguosha.i
	cd swig && swig -c++ -lua sanguosha.i

debug: swig/sanguosha_wrap.cxx $(OLDPWD)/QSanguosha.pro
	mkdir -p $(DEBUG_BUILD)/swig
	cp $(PWD)/swig/sanguosha_wrap.cxx $(DEBUG_BUILD)/swig/sanguosha_wrap.cxx
	cd $(DEBUG_BUILD) && qmake-qt5 $(OLDPWD)/QSanguosha.pro "CONFIG+=debug" && $(MAKE)

release: swig/sanguosha_wrap.cxx $(OLDPWD)/QSanguosha.pro
	mkdir -p $(BUILD)/swig
	cp $(PWD)/swig/sanguosha_wrap.cxx $(BUILD)/swig/sanguosha_wrap.cxx
	cd $(BUILD) && qmake-qt5 $(OLDPWD)/QSanguosha.pro "CONFIG+=release"
	lupdate QSanguosha.pro
	lrelease QSanguosha.pro

.PHONY: release debug
