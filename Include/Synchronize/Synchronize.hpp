#ifndef __SYNCHRONIZE_HPP__
#define __SYNCHRONIZE_HPP__

#include <Process/Process.hpp>

struct ListNode
{
    Process *proc;
    ListNode *next;
};

struct ProcessQueue
{
    ListNode *front;
    ListNode *rear;


    void printAllQueue();
    void init();
    void destroy();
    bool isEmpty();
    int length();
    void enqueue(Process * insertProc);
    Process *front();
    void dequeue();

};

class Semaphore
{
public:
enum:Uint64
{
    TryWait=0,
    KeepWait=(Uint64)-1,
};
enum:unsigned
{
    SignalAll=0,
    SignalOne=1,
};


protected:
int value;
public:

inline void lockProcess()
{
    pm.lock.lock();
}
inline void unlockProcess()
{
    pm.lock.unlock();
}

public:
inline bool wait(Uint64 timeOut=KeepWait)
{


}
inline void signal(unsigned n=SignalOne)
{

}
inline int value()
{
}

inline void init(int _value)
{
    value=_value;

}
inline void destroy()
{
    signal(SignalAll);
}

    	Semaphore(const Semaphore&)=delete;
		Semaphore(const Semaphore&&)=delete;
		Semaphore& operator = (const Semaphore&)=delete;
		Semaphore& operator = (const Semaphore&&)=delete;
};






#endif