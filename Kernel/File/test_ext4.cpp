#include "ext4.h"
#include <Library/KoutSingle.hpp>
#include <LWEXT4_Tools.h>
#define printf kout
#define  EXIT_FAILURE 1

/* 

void test_lwext4_dir_ls(const char *path);
void test_lwext4_mp_stats(void);
void test_lwext4_block_stats(void);
bool test_lwext4_dir_test(int len);
bool test_lwext4_file_test(uint8_t *rw_buff, uint32_t rw_size, uint32_t rw_count);
void test_lwext4_cleanup(void);

bool test_lwext4_mount(struct ext4_blockdev *bdev, struct ext4_bcache *bcache);
bool test_lwext4_umount(void);
 */
// void tim_wait_ms(uint32_t v);

// uint32_t tim_get_ms(void);
// uint64_t tim_get_us(void);

struct ext4_io_stats {
	float io_read;
	float io_write;
	float cpu;
};
/* 
void io_timings_clear(void);
const struct ext4_io_stats *io_timings_get(uint32_t time_sum_ms);
 */

/**@brief   Block device handle.*/
static struct ext4_blockdev *bd;

/**@brief   Block cache handle.*/
static struct ext4_bcache *bc;

static char *entry_to_str(uint8_t type)
{
	switch (type) {
	case EXT4_DE_UNKNOWN:
		return "[unk] ";
	case EXT4_DE_REG_FILE:
		return "[fil] ";
	case EXT4_DE_DIR:
		return "[dir] ";
	case EXT4_DE_CHRDEV:
		return "[cha] ";
	case EXT4_DE_BLKDEV:
		return "[blk] ";
	case EXT4_DE_FIFO:
		return "[fif] ";
	case EXT4_DE_SOCK:
		return "[soc] ";
	case EXT4_DE_SYMLINK:
		return "[sym] ";
	default:
		break;
	}
	return "[???]";
}

// static long int get_ms(void) { return tim_get_ms(); }
/* 
static void printf_io_timings(long int diff)
{
	// const struct ext4_io_stats *stats = io_timings_get(diff);
	if (!stats)
		return;

	printf("io_timings:\n");
	printf("  io_read: %.3f%%\n", (double)stats->io_read);
	printf("  io_write: %.3f%%\n", (double)stats->io_write);
	printf("  io_cpu: %.3f%%\n", (double)stats->cpu);
}
 */
void test_lwext4_dir_ls(const char *path)
{
	char sss[255];
	ext4_dir d;
	const ext4_direntry *de;

	printf("ls %s\n", path);

	ext4_dir_open(&d, path);
	de = ext4_dir_entry_next(&d);

	while (de) {
		memcpy(sss, de->name, de->name_length);
		sss[de->name_length] = 0;
		printf("  %s%s\n", entry_to_str(de->inode_type), sss);
		de = ext4_dir_entry_next(&d);
	}
	ext4_dir_close(&d);
}

void test_lwext4_mp_stats(void)
{
	struct ext4_mount_stats stats;
	ext4_mount_point_stats("/mp/", &stats);

	printf("********************\n");
	printf("ext4_mount_point_stats\n");
	printf("inodes_count = %" PRIu32 "\n", stats.inodes_count);
	printf("free_inodes_count = %" PRIu32 "\n", stats.free_inodes_count);
	printf("blocks_count = %" PRIu32 "\n", (uint32_t)stats.blocks_count);
	printf("free_blocks_count = %" PRIu32 "\n",
	       (uint32_t)stats.free_blocks_count);
	printf("block_size = %" PRIu32 "\n", stats.block_size);
	printf("block_group_count = %" PRIu32 "\n", stats.block_group_count);
	printf("blocks_per_group= %" PRIu32 "\n", stats.blocks_per_group);
	printf("inodes_per_group = %" PRIu32 "\n", stats.inodes_per_group);
	printf("volume_name = %s\n", stats.volume_name);
	printf("********************\n");
}

void test_lwext4_block_stats(void)
{
	if (!bd)
		return;

	printf("********************\n");
	printf("ext4 blockdev stats\n");
	printf("bdev->bread_ctr = %" PRIu32 "\n", bd->bdif->bread_ctr);
	printf("bdev->bwrite_ctr = %" PRIu32 "\n", bd->bdif->bwrite_ctr);

	printf("bcache->ref_blocks = %" PRIu32 "\n", bd->bc->ref_blocks);
	printf("bcache->max_ref_blocks = %" PRIu32 "\n", bd->bc->max_ref_blocks);
	printf("bcache->lru_ctr = %" PRIu32 "\n", bd->bc->lru_ctr);

	printf("\n");

	printf("********************\n");
}
/* 
bool test_lwext4_dir_test(int len)
{
	ext4_file f;
	int r;
	int i;
	char path[64];
	long int diff;
	long int stop;
	long int start;

	printf("test_lwext4_dir_test: %d\n", len);
	io_timings_clear();
	start = get_ms();

	printf("directory create: /mp/dir1\n");
	r = ext4_dir_mk("/mp/dir1");
	if (r != EOK) {
		printf("ext4_dir_mk: rc = %d\n", r);
		return false;
	}

	printf("add files to: /mp/dir1\n");
	for (i = 0; i < len; ++i) {
		// sprintf(path, "/mp/dir1/f%d", i);
        strcpy(path,"" );
		r = ext4_fopen(&f, path, "wb");
		if (r != EOK) {
			printf("ext4_fopen: rc = %d\n", r);
			return false;
		}
	}

	stop = get_ms();
	diff = stop - start;
	test_lwext4_dir_ls("/mp/dir1");
	printf("test_lwext4_dir_test: time: %d ms\n", (int)diff);
	printf("test_lwext4_dir_test: av: %d ms/entry\n", (int)diff / (len + 1));
	printf_io_timings(diff);
	return true;
}
 */
static int verify_buf(const unsigned char *b, size_t len, unsigned char c)
{
	size_t i;
	for (i = 0; i < len; ++i) {
		if (b[i] != c)
			return c - b[i];
	}

	return 0;
}

bool test_lwext4_file_test(uint8_t *rw_buff, uint32_t rw_size, uint32_t rw_count)
{
	int r;
	size_t size;
	uint32_t i;
	long int start;
	long int stop;
	long int diff;
	uint32_t kbps;
	uint64_t size_bytes;

	ext4_file f;

	printf("file_test:\n");
	printf("  rw size: %" PRIu32 "\n", rw_size);
	printf("  rw count: %" PRIu32 "\n", rw_count);

	/*Add hello world file.*/
	r = ext4_fopen(&f, "/mp/hello1.txt", "wb");
	r = ext4_fwrite(&f, "Hello World !\n", strlen("Hello World !\n"), 0);
	//SBI_SHUTDOWN();
	r = ext4_fclose(&f);

	// io_timings_clear();
	// start = get_ms();
	r = ext4_fopen(&f, "/mp/test1", "wb");
	if (r != EOK) {
		printf("ext4_fopen ERROR = %d\n", r);
		return false;
	}

	printf("ext4_write: %" PRIu32 " * %" PRIu32 " ...\n", rw_size,
	       rw_count);
	for (i = 0; i < rw_count; ++i) {

		memset(rw_buff, i % 10 + '0', rw_size);

		r = ext4_fwrite(&f, rw_buff, rw_size, &size);

		if ((r != EOK) || (size != rw_size))
			break;
	}

	if (i != rw_count) {
		printf("  file_test: rw_count = %" PRIu32 "\n", i);
		return false;
	}

	// stop = get_ms();
	diff = stop - start;
	size_bytes = rw_size * rw_count;
	size_bytes = (size_bytes * 1000) / 1024;
	kbps = (size_bytes) / (diff + 1);
	printf("  write time: %d ms\n", (int)diff);
	printf("  write speed: %" PRIu32 " KB/s\n", kbps);
	// printf_io_timings(diff);
	r = ext4_fclose(&f);

	// io_timings_clear();
	// start = get_ms();
	r = ext4_fopen(&f, "/mp/test1", "r+");
	if (r != EOK) {
		printf("ext4_fopen ERROR = %d\n", r);
		return false;
	}

	printf("ext4_read: %" PRIu32 " * %" PRIu32 " ...\n", rw_size, rw_count);

	for (i = 0; i < rw_count; ++i) {
		r = ext4_fread(&f, rw_buff, rw_size, &size);

		if ((r != EOK) || (size != rw_size))
			break;

		if (verify_buf(rw_buff, rw_size, i % 10 + '0'))
			break;
	}

	if (i != rw_count) {
		printf("  file_test: rw_count = %" PRIu32 "\n", i);
		return false;
	}

	// stop = get_ms();
	diff = stop - start;
	size_bytes = rw_size * rw_count;
	size_bytes = (size_bytes * 1000) / 1024;
	kbps = (size_bytes) / (diff + 1);
	printf("  read time: %d ms\n", (int)diff);
	printf("  read speed: %d KB/s\n", (int)kbps);
	// printf_io_timings(diff);

	r = ext4_fclose(&f);
	return true;
}
void test_lwext4_cleanup(void)
{
	long int start;
	long int stop;
	long int diff;
	int r;

	printf("\ncleanup:\n");
	r = ext4_fremove("/mp/hello.txt");
	if (r != EOK && r != ENOENT) {
		printf("ext4_fremove error: rc = %d\n", r);
	}

	printf("remove /mp/test1\n");
	r = ext4_fremove("/mp/test1");
	if (r != EOK && r != ENOENT) {
		printf("ext4_fremove error: rc = %d\n", r);
	}

	printf("remove /mp/dir1\n");
	// io_timings_clear();
	// start = get_ms();
	r = ext4_dir_rm("/mp/dir1");
	if (r != EOK && r != ENOENT) {
		printf("ext4_fremove ext4_dir_rm: rc = %d\n", r);
	}
	// stop = get_ms();
	diff = stop - start;
	printf("cleanup: time: %d ms\n", (int)diff);
	// printf_io_timings(diff);
}

bool test_lwext4_mount(struct ext4_blockdev *bdev, struct ext4_bcache *bcache)
{
	int r;

	bc = bcache;
	bd = bdev;

	if (!bd) {
		printf("test_lwext4_mount: no block device\n");
		return false;
	}

	ext4_dmask_set(DEBUG_ALL);

	r = ext4_device_register(bd, "ext4_fs");
	if (r != EOK) {
		printf("ext4_device_register: rc = %d\n", r);
		return false;
	}

	r = ext4_mount("ext4_fs", "/mp/", false);
	if (r != EOK) {
		printf("ext4_mount: rc = %d\n", r);
		return false;
	}

	r = ext4_recover("/mp/");
	if (r != EOK && r != ENOTSUP) {
		printf("ext4_recover: rc = %d\n", r);
		return false;
	}

	r = ext4_journal_start("/mp/");
	if (r != EOK) {
		printf("ext4_journal_start: rc = %d\n", r);
		return false;
	}

	ext4_cache_write_back("/mp/", 1);
    
    
	return true;
}

bool test_lwext4_umount(void)
{
	int r;

	ext4_cache_write_back("/mp/", 0);

	r = ext4_journal_stop("/mp/");
	if (r != EOK) {
		printf("ext4_journal_stop: fail %d", r);
		return false;
	}

	r = ext4_umount("/mp/");
	if (r != EOK) {
		printf("ext4_umount: fail %d", r);
		return false;
	}
	return true;
}



char input_name[128] = "ext_images/ext2";
/**@brief   Read-write size*/
static int rw_szie = 1024 * 1024;

/**@brief   Read-write size*/
static int rw_count = 10;

/**@brief   Directory test count*/
static int dir_cnt = 0;

/**@brief   Cleanup after test.*/
static bool cleanup_flag = false;

/**@brief   Block device stats.*/
static bool bstat = false;

/**@brief   Superblock stats.*/
static bool sbstat = false;

/**@brief   Indicates that input is windows partition.*/
static bool winpart = false;

/**@brief   Verbose mode*/
static bool verbose = 0;

/**@brief   Block device handle.*/
// static struct ext4_blockdev *bd;

/**@brief   Block cache handle.*/
// static struct ext4_bcache *bc;

static const char *usage = "                                    \n\
Welcome in ext4 generic demo.                                   \n\
Copyright (c) 2013 Grzegorz Kostka (kostka.grzegorz@gmail.com)  \n\
Usage:                                                          \n\
[-i] --input    - input file         (default = ext2)           \n\
[-w] --rw_size  - single R/W size    (default = 1024 * 1024)    \n\
[-c] --rw_count - R/W count          (default = 10)             \n\
[-d] --dirs   - directory test count (default = 0)              \n\
[-l] --clean  - clean up after test                             \n\
[-b] --bstat  - block device stats                              \n\
[-t] --sbstat - superblock stats                                \n\
[-w] --wpart  - windows partition mode                          \n\
\n";

void io_timings_clear(void)
{
}

const struct ext4_io_stats *io_timings_get(uint32_t time_sum_ms)
{
	return NULL;
}
/* 
uint32_t tim_get_ms(void)
{
	struct timeval t;
	gettimeofday(&t, NULL);
	return (t.tv_sec * 1000) + (t.tv_usec / 1000);
}
uint64_t tim_get_us(void)
{
	struct timeval t;
	gettimeofday(&t, NULL);
	return (t.tv_sec * 1000000) + (t.tv_usec);
}
 */

struct ext4_blockdev *ext4_blockdev_get(void);

static bool open_linux(void)
{
	// file_dev_name_set(input_name);
	bd = ext4_blockdev_get();
	if (!bd) {
		printf("open_filedev: fail\n");
		return false;
	}
	return true;
}


static bool open_filedev(void)
{
	return  open_linux();
}
/* 
static bool parse_opt(int argc, char **argv)
{
	int option_index = 0;
	int c;

	static struct option long_options[] = {
	    {"input", required_argument, 0, 'i'},
	    {"rw_size", required_argument, 0, 's'},
	    {"rw_count", required_argument, 0, 'c'},
	    {"dirs", required_argument, 0, 'd'},
	    {"clean", no_argument, 0, 'l'},
	    {"bstat", no_argument, 0, 'b'},
	    {"sbstat", no_argument, 0, 't'},
	    {"wpart", no_argument, 0, 'w'},
	    {"verbose", no_argument, 0, 'v'},
	    {"version", no_argument, 0, 'x'},
	    {0, 0, 0, 0}};

	while (-1 != (c = getopt_long(argc, argv, "i:s:c:q:d:lbtwvx",
				      long_options, &option_index))) {

		switch (c) {
		case 'i':
			strcpy(input_name, optarg);
			break;
		case 's':
			rw_szie = atoi(optarg);
			break;
		case 'c':
			rw_count = atoi(optarg);
			break;
		case 'd':
			dir_cnt = atoi(optarg);
			break;
		case 'l':
			cleanup_flag = true;
			break;
		case 'b':
			bstat = true;
			break;
		case 't':
			sbstat = true;
			break;
		case 'w':
			winpart = true;
			break;
		case 'v':
			verbose = true;
			break;
		case 'x':
			puts(VERSION);
			exit(0);
			break;
		default:
			printf("%s", usage);
			return false;
		}
	}
	return true;
}
 */


int test_ext4()
{
	// if (!parse_opt(argc, argv))
		// return EXIT_FAILURE;

	printf("ext4_generic\n");
	printf("test conditions:\n");
	printf("\timput name: %s\n", input_name);
	printf("\trw size: %d\n", rw_szie);
	printf("\trw count: %d\n", rw_count);

	if (!open_filedev()) {
		printf("open_filedev error\n");
		return EXIT_FAILURE;
	}


	if (!test_lwext4_mount(bd, bc))
		return EXIT_FAILURE;

	test_lwext4_cleanup();

	if (sbstat)
		test_lwext4_mp_stats();

	test_lwext4_dir_ls("/mp/");

	ext4_frename("/mp/lib/my.so","/mp/lib/dlopen_dso.so");
	// fflush(stdout);

	// if (!test_lwext4_dir_test(dir_cnt))
		// return EXIT_FAILURE;

	// fflush(stdout);
	uint8_t *rw_buff =(uint8_t *) malloc(rw_szie);
	if (!rw_buff) {
		free(rw_buff);
		return EXIT_FAILURE;
	}
	if (!test_lwext4_file_test(rw_buff, rw_szie, rw_count)) {
		free(rw_buff);
		return EXIT_FAILURE;
	}

	free(rw_buff);

	// fflush(stdout);
	test_lwext4_dir_ls("/mp/");

	if (sbstat)
		test_lwext4_mp_stats();

	// if (cleanup_flag)
		// test_lwext4_cleanup();

	if (bstat)
		test_lwext4_block_stats();

	if (!test_lwext4_umount())
		return EXIT_FAILURE;

	printf("\ntest finished\n");
	return 0;
}