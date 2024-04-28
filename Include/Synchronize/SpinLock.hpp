#ifndef __SPINLOCK_HPP__
#define __SPINLOCK_HPP__
class SpinLock
{

public:
    volatile bool spinLock = 0;
    inline bool TryLock()
    {
        bool old = __sync_lock_test_and_set(&spinLock, 1);
        __sync_synchronize();
        return !old;
    }

    inline void unlock()
    {
        __sync_synchronize();
        __sync_lock_release(&spinLock);
    }

    inline void lock()
    {
        while (__sync_lock_test_and_set(&spinLock, 1) != 0)
            ;
        __sync_synchronize();
    }
    inline void init()
    {
        spinLock = 0;
    }
};

#endif