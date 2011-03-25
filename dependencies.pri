######################################################################
# Extlibs
######################################################################

declare(newmat,    extlibs/newmat)
declare(tinyxml,   extlibs/tinyxml)
declare(eigen,     extlibs/eigen-3.0-beta4/eigen.pro)
declare(qwt,       extlibs/qwt-5.2.0/src)
declare(QGLViewer, extlibs/libQGLViewer-2.3.3/QGLViewer)

!contains(DEFINES,SOFA_HAVE_FLOWVR){
  declare(miniFlowVR, extlibs/miniFlowVR)
}

######################################################################
# Framework
######################################################################

declare(sofahelper,      framework/sofa/helper,      newmat)
declare(sofadefaulttype, framework/sofa/defaulttype, sofahelper)
declare(sofacore,        framework/sofa/core,        sofadefaulttype)

######################################################################
# Modules
######################################################################

declare(sofasimulation, modules/sofa/simulation/common, sofacore)
declare(sofatree,       modules/sofa/simulation/tree,   sofasimulation)
declare(sofabgl,        modules/sofa/simulation/bgl,    sofasimulation)
declare(sofapml,        modules/sofa/simulation/filemanager/sofapml, sofacomponentcollision)

declare(sofacomponentbase,          modules/sofa/component/libbase.pro,   sofatree miniFlowVR)
declare(sofacomponentbehaviormodel, modules/sofa/component/behaviormodel, sofatree)
declare(sofacomponentcontextobject, modules/sofa/component/contextobject, sofatree)
declare(sofacomponentengine,        modules/sofa/component/engine,        sofacomponentcollision)
declare(sofacomponentfem,           modules/sofa/component/fem,           sofacomponentbase eigen)
declare(sofacomponentforcefield,    modules/sofa/component/forcefield,    sofacomponentbase eigen)
declare(sofacomponentloader,        modules/sofa/component/loader,        sofatree tinyxml)
declare(sofacomponentmapping,       modules/sofa/component/mapping,       sofacomponentforcefield sofacomponentvisualmodel)
declare(sofacomponentmass,          modules/sofa/component/mass,          sofacomponentbase)
declare(sofacomponentodesolver,     modules/sofa/component/odesolver,     sofatree)
declare(sofacomponentvisualmodel,   modules/sofa/component/visualmodel,   sofacomponentbase tinyxml)

declare(sofacomponentconstraintset, modules/sofa/component/constraintset, sofacomponentlinearsolver sofacomponentmass)
declare(sofacomponentlinearsolver,  modules/sofa/component/linearsolver,  sofacomponentodesolver sofacomponentforcefield)

declare(sofacomponentinteractionforcefield,    modules/sofa/component/interactionforcefield,   sofacomponentforcefield)
declare(sofacomponentprojectiveconstraintset,  modules/sofa/component/projectiveconstraintset, sofacomponentlinearsolver sofacomponentmass)
declare(sofacomponentmastersolver,  modules/sofa/component/mastersolver,  sofacomponentconstraintset sofacomponentprojectiveconstraintset)

declare(sofacomponentcontroller, modules/sofa/component/controller, sofacomponentmastersolver sofacomponentinteractionforcefield)

declare(sofacomponentcollision, modules/sofa/component/collision, \
  sofacomponentconstraintset sofacomponentprojectiveconstraintset \
  sofacomponentmapping sofacomponentinteractionforcefield sofabgl)

declare(sofacomponentmisc, modules/sofa/component/misc,  \
  sofacomponentcontroller sofacomponentcollision sofacomponentfem \
  sofacomponentcontextobject sofacomponentbehaviormodel)

declare(sofacomponentconfigurationsetting, modules/sofa/component/configurationsetting, sofacomponentmisc)

declare(sofacomponent, modules/sofa/component/libcomponent.pro, \
  sofacomponentconfigurationsetting sofacomponentloader sofacomponentengine)

######################################################################
# Applications
######################################################################

declare(sofagui,     applications/sofa/gui/libgui.pro,     sofacomponentconfigurationsetting)
declare(sofaguiqt,   applications/sofa/gui/qt,             sofagui qwt QGLViewer)
declare(sofaguimain, applications/sofa/gui/libguimain.pro, sofaguiqt)
declare(sofaguiglut, applications/sofa/gui/glut,           sofagui)
declare(sofaguifltk, applications/sofa/gui/fltk,           sofaguiqt)
