#ifndef __SYNCHRONIZE_HPP__
#define __SYNCHRONIZE_HPP__

#include <Process/Process.hpp>
#include <Types.hpp>


struct ListNode {
    Process* proc;
    ListNode* next;
};

struct ProcessQueue {
    ListNode* front;
    ListNode* rear;

    void printAllQueue();
    void init();
    void destroy();
    bool isEmpty();
    int length();
    void enqueue(Process* insertProc);
    Process* getFront();
    void dequeue();
    bool check(Process* _check);
};

class Semaphore {
public:
    enum : Uint64 {
        TryWait = 0,
        KeepWait = (Uint64)-1,
    };
    enum : unsigned {
        SignalAll = 0,
        SignalOne = 1,
    };

protected:
    int value;
    ProcessQueue queue;

public:
    inline void printAllWaitProcess()
    {
       queue.printAllQueue(); 
    }

    inline void lockProcess()
    {
            // kout[DeBug]<<"lock"<<endl;
        pm.lock.lock();
    }
    inline void unlockProcess()
    {
        pm.lock.unlock();
    }

public:
    int wait(Process* proc = pm.getCurProc());
    void signal();
    int getValue();

    Semaphore(int _value)
    {
        // kout<<_value<<endl;
        if (_value < 0) {
            kout[Fault] << "semaphore's value should not be negative" << endl;
        }

        value = _value;
        queue.init();
    }

    Semaphore()
    {
        value = 0;
        queue.init();
    }

    inline void destroy()
    {
        queue.destroy();
    }
    ~Semaphore()
    {
        this->destroy();
    }

    Semaphore(const Semaphore&) = delete;
    Semaphore(const Semaphore&&) = delete;
    Semaphore& operator=(const Semaphore&) = delete;
    Semaphore& operator=(const Semaphore&&) = delete;
};

class Mutex : public Semaphore {
public:
    inline void Lock()
    {
        wait();
    }

    inline void Unlock()
    {
        signal();
    }

    inline bool TryLock()
    {
        return wait();
    } //

    Mutex()
    {
    } //
};

#endif