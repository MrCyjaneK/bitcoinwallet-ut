#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "process.h"

void ProcessPlugin::registerTypes(const char *uri) {
    //@uri Example
    qmlRegisterSingletonType<Process>(uri, 1, 0, "Process", [](QQmlEngine*, QJSEngine*) -> QObject* { return new Process; });
}
