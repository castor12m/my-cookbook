#define _AMD64_
#include <wdm.h>

NTSTATUS DriverEntry(void* a, void* b) {
    DbgPrint("hello hyunmin!");
    return STATUS_SUCCESS;
}