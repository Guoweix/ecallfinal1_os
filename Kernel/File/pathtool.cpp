#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>

char* split_path_name(char* path, char* buf)
{
    if (path == nullptr || path[0] == 0) {
        return nullptr;
    }
    char* t = path;

    int i = 0;
    while (*t != 0 && *t != '/') {
        buf[i] = *t;
        i++;
        t++;
    }

    buf[i] = 0;
    return t + 1;
}

char* unicode_to_ascii(char* str)
{
    char* t = str;
    while (*t) {
        *str++ = *t;
        t += 2;
    }
    *str = *t;

    return str;
}

char* unicode_to_ascii(char* str, char* buf)
{
    char* t = str;
    int i = 0;
    while (*t) {
        buf[i++] = *t;
        t += 2;
    }
    buf[i] = *t;
    return buf;
}

char* pathcmp(char* pathfile, char* pathVMS)
{
    while (*pathVMS != '\0') {
        if (*pathfile != *pathVMS)
            return nullptr;
        pathfile++;
        pathVMS++;
    }

    return pathfile;
}

bool toshortname(const char* fileName, char* shortName)
{
    Uint64 re = 0;
    Uint64 t;
    while (re < 8 && fileName[re] != '\0' && fileName[re] != '.') {
        shortName[re] = fileName[re];
        re++;
    }

    t = re;

    if (re == 8 && fileName[re] != '.' && fileName[re] != '\0') {
        shortName[6] = '~';
        shortName[7] = '1';
    }

    while (re < 8) {
        shortName[re] = ' ';
        re++;
    }

    while (fileName[t] != '.' && fileName[t] != '\0') {
        t++;
    }
    if (fileName[t] == '.') {
        shortName[8] = fileName[t + 1] != '\0' ? fileName[t + 1] : ' ';
        shortName[9] = fileName[t + 2] != '\0' ? fileName[t + 2] : ' ';
        shortName[10] = fileName[t + 3] != '\0' ? fileName[t + 3] : ' ';
    }

    return true;
}

char* unicodecopy(char* dst, char* src, int len)
{
    int re = 0;
    // kout[purple] << src << endl;
    while (re < len && src[re] != 0) {
        dst[2 * re] = src[re];
        dst[2 * re + 1] = 0;
        re++;
    }
    if (re < len) {
        dst[2 * re] = 0;
        dst[2 * re + 1] = 0;
    }

    return &src[re];
}

bool unified_file_path(char* src, char* ret)
{

    char* siglename = new char[50];
    // char* re = new char[200];
    ret[0] = 0;
    while ((src = split_path_name(src, siglename)) != 0) {
        switch (siglename[0]) {
        case '.':
            if (siglename[1] == '.') {
                int len = strlen(ret);
                if (len <= 1) {
                    delete[] siglename;
                    return false;                    
                }
                char* t = &ret[len - 2];
                while (t != ret) {
                    if (*t == '/') {
                        t++;
                        *t = 0;
                        break;
                    }
                    t--;
                }
                *t = 0;
            }
            break;
        default:
            strcat(ret, siglename);
            strcat(ret, "/");
        }
    }
    delete[] siglename;
    return true;
}

char* unified_path(char* path, char* cwd, char* ret)
{
    char* path1 = new char[400];
    ret[0] = 0;
    if(!unified_file_path(path, path1))
    {
        return nullptr;//如果返回nullptr则说明路径错误
    }
    if (path[0]!='/') {
        strcpy(ret, path1);
        delete[] path1;
        return ret;
    }

    char* cwd1 = new char[400];
    unified_file_path(cwd, cwd1);

    strcpy(ret, cwd1);
    strcat(ret, path1);
    delete[] path1;
    delete[] cwd1;

    return ret;
}
