/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package cfa/native */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h>

#ifndef GO_CGO_EXPORT_PROLOGUE_H
#define GO_CGO_EXPORT_PROLOGUE_H

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef struct { const char *p; ptrdiff_t n; } _GoString_;
#endif

#endif

/* Start of preamble from import "C" comments.  */


#line 3 "app.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"

#line 3 "config.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"

#line 3 "log.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"

#line 3 "main.go"



#include "bridge.h"


#line 1 "cgo-generated-wrapper"

#line 3 "proxy.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"

#line 3 "tun.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"

#line 3 "tunnel.go"
#include "bridge.h"

#line 1 "cgo-generated-wrapper"


/* End of preamble from import "C" comments.  */


/* Start of boilerplate cgo prologue.  */
#line 1 "cgo-gcc-export-header-prolog"

#ifndef GO_CGO_PROLOGUE_H
#define GO_CGO_PROLOGUE_H

typedef signed char GoInt8;
typedef unsigned char GoUint8;
typedef short GoInt16;
typedef unsigned short GoUint16;
typedef int GoInt32;
typedef unsigned int GoUint32;
typedef long long GoInt64;
typedef unsigned long long GoUint64;
typedef GoInt64 GoInt;
typedef GoUint64 GoUint;
typedef size_t GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;
#ifdef _MSC_VER
#include <complex.h>
typedef _Fcomplex GoComplex64;
typedef _Dcomplex GoComplex128;
#else
typedef float _Complex GoComplex64;
typedef double _Complex GoComplex128;
#endif

/*
  static assertion to make sure the file is being used on architecture
  at least with matching size of GoInt.
*/
typedef char _check_for_64_bit_pointer_matching_GoInt[sizeof(void*)==64/8 ? 1:-1];

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef _GoString_ GoString;
#endif
typedef void *GoMap;
typedef void *GoChan;
typedef struct { void *t; void *v; } GoInterface;
typedef struct { void *data; GoInt len; GoInt cap; } GoSlice;

#endif

/* End of boilerplate cgo prologue.  */

#ifdef __cplusplus
extern "C" {
#endif

// extern void notifyDnsChanged(c_string dnsList);
// extern void notifyInstalledAppsChanged(c_string uids);
// extern void notifyTimeZoneChanged(c_string name, int offset);
// extern char* queryConfiguration();
// extern void fetchAndValid(void* callback, c_string path, c_string url, int force);
// extern void load(void* completable, c_string path);
// extern char* readOverride(int slot);
// extern void writeOverride(int slot, c_string content);
// extern void clearOverride(int slot);
// extern void subscribeLogcat(void* remote);
// extern void coreInit(c_string home, c_string versionName, int sdkVersion);
// extern void reset();
// extern void forceGc();
// extern char* startHttp(c_string listenAt);
// extern void stopHttp();
// extern int startTun(int fd, c_string gateway, c_string portal, c_string dns, void* callback);
// extern void stopTun();
// extern char* queryTunnelState();
// extern void queryNow(uint64_t* upload, uint64_t* download);
// extern void queryTotal(uint64_t* upload, uint64_t* download);
// extern char* queryGroupNames(int excludeNotSelectable);
// extern char* queryGroup(c_string name, c_string sortMode);
// extern void healthCheck(void* completable, c_string name);
// extern void healthCheckAll();
// extern int patchSelector(c_string selector, c_string name);
// extern char* queryProviders();
// extern void updateProvider(void* completable, c_string pType, c_string name);
// extern void suspend(int suspended);
// extern char* installSideloadGeoip(void* block, int blockSize);

#ifdef __cplusplus
}
#endif
