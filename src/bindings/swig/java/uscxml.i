%module(directors="1", allprotected="1") uscxmlNativeJava

// provide a macro for the header files
#define SWIGIMPORTED 1

%include <stl.i>
%include <std_map.i>
%include <std_string.i>
%include <inttypes.i>
%include "../stl_set.i"
%include "../stl_list.i"

%include <boost_shared_ptr.i>

typedef uscxml::Data Data;
typedef uscxml::Event Event;
typedef uscxml::InvokeRequest InvokeRequest;
typedef uscxml::SendRequest SendRequest;

%feature("director") uscxml::WrappedInvoker;
%feature("director") uscxml::WrappedDataModel;
%feature("director") uscxml::WrappedIOProcessor;
%feature("director") uscxml::WrappedExecutableContent;
%feature("director") uscxml::WrappedInterpreterMonitor;

// disable warning related to unknown base class
#pragma SWIG nowarn=401
// do not warn when we override symbols via extend
#pragma SWIG nowarn=302

%javaconst(1);

%rename(equals) operator==; 
%rename(isValid) operator bool;


//**************************************************
// This ends up in the generated wrapper code
//**************************************************

%{

#include "../../../uscxml/Message.h"
#include "../../../uscxml/Factory.h"
#include "../../../uscxml/Interpreter.h"
#include "../../../uscxml/concurrency/BlockingQueue.h"

#include "../wrapped/WrappedInvoker.h"
#include "../wrapped/WrappedDataModel.h"
#include "../wrapped/WrappedExecutableContent.h"
#include "../wrapped/WrappedIOProcessor.h"
#include "../wrapped/WrappedInterpreterMonitor.h"

using namespace uscxml;
using namespace Arabica::DOM;

#include "../wrapped/WrappedInvoker.cpp"
#include "../wrapped/WrappedDataModel.cpp"
#include "../wrapped/WrappedExecutableContent.cpp"
#include "../wrapped/WrappedIOProcessor.cpp"
#include "../wrapped/WrappedInterpreterMonitor.cpp"

%}

%define WRAP_THROW_EXCEPTION( MATCH )
%javaexception("org.uscxml.InterpreterException") MATCH {
  try {
    $action
  }
  catch ( uscxml::Event& e ) {
    jclass eclass = jenv->FindClass("org/uscxml/InterpreterException");
    if ( eclass ) {
      std::stringstream ss;
      ss << std::endl << e;
      jenv->ThrowNew( eclass, ss.str().c_str() );
    }
  }
}
%enddef

WRAP_THROW_EXCEPTION(uscxml::Interpreter::fromXML);
WRAP_THROW_EXCEPTION(uscxml::Interpreter::fromURI);
WRAP_THROW_EXCEPTION(uscxml::Interpreter::step);
WRAP_THROW_EXCEPTION(uscxml::Interpreter::interpret);


%include "../uscxml_ignores.i"

%rename Data DataNative;

%include "../uscxml_beautify.i"


//***********************************************
// Parse the header file to generate wrappers
//***********************************************

%include "../../../uscxml/Common.h"
%include "../../../uscxml/Factory.h"
%include "../../../uscxml/Message.h"
%include "../../../uscxml/Interpreter.h"
%include "../../../uscxml/concurrency/BlockingQueue.h"

%include "../../../uscxml/messages/Blob.h"
%include "../../../uscxml/messages/Data.h"
%include "../../../uscxml/messages/Event.h"
%include "../../../uscxml/messages/InvokeRequest.h"
%include "../../../uscxml/messages/SendRequest.h"

%include "../../../uscxml/plugins/DataModel.h"
%include "../../../uscxml/plugins/EventHandler.h"
%include "../../../uscxml/plugins/ExecutableContent.h"
%include "../../../uscxml/plugins/Invoker.h"
%include "../../../uscxml/plugins/IOProcessor.h"

%include "../wrapped/WrappedInvoker.h"
%include "../wrapped/WrappedDataModel.h"
%include "../wrapped/WrappedExecutableContent.h"
%include "../wrapped/WrappedIOProcessor.h"
%include "../wrapped/WrappedInterpreterMonitor.h"


%template(DataList) std::list<uscxml::Data>;
%template(DataMap) std::map<std::string, uscxml::Data>;
%template(StringSet) std::set<std::string>;
%template(StringVector) std::vector<std::string>;
%template(StringList) std::list<std::string>;
%template(ParamPair) std::pair<std::string, uscxml::Data>;
%template(ParamPairVector) std::vector<std::pair<std::string, uscxml::Data> >;
%template(IOProcMap) std::map<std::string, uscxml::IOProcessor>;
%template(InvokerMap) std::map<std::string, uscxml::Invoker>;
%template(ParentQueue) uscxml::concurrency::BlockingQueue<uscxml::SendRequest>;
