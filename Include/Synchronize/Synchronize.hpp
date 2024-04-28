#ifndef __SYNCHRONIZE_HPP__
#define __SYNCHRONIZE_HPP__

#include <Process/Process.hpp>
#include <Memory/slab.hpp>
#include <Library/KoutSingle.hpp>
#include <Trap/Interrupt.hpp>

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
    void enqueue(Process *insertProc);
    Process *getFront();
    void dequeue();
};

class Semaphore
{
public:
    enum : Uint64
    {
        TryWait = 0,
        KeepWait = (Uint64)-1,
    };
    enum : unsigned
    {
        SignalAll = 0,
        SignalOne = 1,
    };

protected:
    int value;
    ProcessQueue queue;

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
    int wait(Process * proc=pm.getCurProc());
    void signal(Process * proc=pm.getCurProc());
    int getValue();

    inline void init(int _value)
    {
        if (value < 0)
        {
            kout[Fault] << "semaphore's value should not be negative" << endl;
        }

        value = _value;
        queue.init();
    }
    inline void destroy()
    {
        queue.destroy();
    }

    Semaphore(const Semaphore &) = delete;
    Semaphore(const Semaphore &&) = delete;
    Semaphore &operator=(const Semaphore &) = delete;
    Semaphore &operator=(const Semaphore &&) = delete;
};

#endif