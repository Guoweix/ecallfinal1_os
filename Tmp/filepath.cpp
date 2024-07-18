#include <cstring>
#include <iostream>
#include <linux/unistd.h>
using namespace std;
const char* split_path_name(const char* path, char* buf)
{

    if (path == nullptr || path[0] == 0) {
        return nullptr;
    }
    const char* t = path;

    int i = 0;
    while (*t != 0 && *t != '/') {
        buf[i] = *t;
        i++;
        t++;
    }

    buf[i] = 0;
    return t+1;
    // return ((*t)==0)?nullptr:(t+1);
}




bool unified_file_path(const char* src, char* ret)
{

    char* siglename = new char[50];
    // char* re = new char[200];
    ret[0] = 0;
    int i=0;
    while ((src = split_path_name(src, siglename)) != 0) {
        cout<<siglename<<endl;
        cout<<i++<<endl;
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

char* unified_path(const char* path,const char* cwd, char* ret)
{
    char* path1 = new char[400];     
    ret[0] = 0;
    if(!unified_file_path(path, path1))
    {
        return nullptr;//如果返回nullptr则说明路径错误
    }
    if (path[0]=='/') {

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


//输入中末尾的/会被自动去掉
int main()
{
    char* path;
    char* cwd;
    char* ret;
    path = new char[200];
    cwd = new char[200];
    ret = new char[200];
    strcpy(path, "test_openat.txt");
    strcpy(cwd, "/mnt");
    
    unified_path(path, cwd, ret);
    cout<<ret<<endl;
    //
    /* while (path=split_path_name(path, ret )) {
        cout<<ret<<endl;
        cout<<(ret[0]==0)<<endl;

    } */
        


    return 0;
}