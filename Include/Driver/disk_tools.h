#ifndef __DISK_TOOLS_H__
#define __DISK_TOOLS_H__

int readSector1(unsigned long long LBA, void* sec, int cnt);
int writeSector1(unsigned long long LBA, const void* sec, int cnt);

#endif