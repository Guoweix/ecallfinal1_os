#ifndef POS_ERROR_HPP
#define POS_ERROR_HPP

enum
{
	ERR_None=0,
	ERR_Unknown,
	ERR_Todo,
	ERR_KmallocFailed,
	ERR_OutOfMemory,
	ERR_AccessInvalidVMR,
	ERR_AccessPermissionViolate,
	ERR_BusyForking,
	ERR_InvalidParameter,//for unknown specific reasons
	ERR_FileOperationOutofRange,
	ERR_FileSeekOutOfRange,
	ERR_VertifyNumberDisagree,
	ERR_VersionError,
	ERR_FileAlreadyExist,
	ERR_FilePathNotExist,
	ERR_DirectoryPathNotExist,
	ERR_PathIsNotDirectory,
	ERR_PathIsNotFile,
	ERR_PathIsNull,
	ERR_FileNameTooLong,
	ERR_InvalidClusterNumInFAT32,
	ERR_InvalidFileHandlePermission,
	ERR_TargetExist,
	ERR_UnsuppoertedVirtualFunction,
	ERR_FileEmpty,
	ERR_DeviceReadError,
	ERR_DeviceWriteError,
	ERR_UnmountDeviceError,
	ERR_LockDeviceError,
	ERR_DeviceInitialError,
	ERR_HeapCollision,
	ERR_InvalidRangeOfVMR,
	ERR_DiskRwOutOfRange,
	ERR_FileOccupied
};

#endif
