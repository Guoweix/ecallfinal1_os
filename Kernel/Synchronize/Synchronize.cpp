#include "Process/Process.hpp"
#include <Library/KoutSingle.hpp>
#include <Memory/slab.hpp>
#include <Synchronize/Synchronize.hpp>
#include <Trap/Interrupt.hpp>

void ProcessQueue::printAllQueue()
{
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    ListNode* nxt = front->next;

    while (nxt != nullptr) {
        nxt->proc->show();
        nxt = nxt->next;
    }
}

void ProcessQueue::init()
{
    // front = (ListNode*)slab.allocate(sizeof(ListNode));
    front = new ListNode;

    rear = front;
    if (front == nullptr)
        kout[Fault] << "process Queue Init Falied" << endl;
    front->next = nullptr;
}

bool ProcessQueue::isEmpty()
{
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    return front == rear;
}

int ProcessQueue::length()
{
    int re = 0;
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    ListNode* nxt = front->next;

    while (nxt != nullptr) {
        re++;
        nxt = nxt->next;
    }
    return re;
}

void ProcessQueue::destroy()
{
    ListNode* nxt = front;

    while (nxt != nullptr) {
        ListNode* t = nxt;
        nxt = nxt->next;
        delete t;
    }
}

Process* ProcessQueue::getFront()
{
    kout<<Yellow<<"getFront"<<endl;
    if (isEmpty()) {
        kout[Fault] << "process queue is empty" << endl;
    }
    // kout<<Yellow<<"getFront"<<front->next<<endl;
    
    return front->next->proc;
}

bool ProcessQueue::check(Process* _check)
{

    ListNode* nxt = front->next;

    while (nxt != nullptr) {
        if (nxt->proc == _check) {
            return true;
        }
        nxt = nxt->next;
    }
    return false;
}

void ProcessQueue::enqueue(Process* insertProc)
{
    ListNode* t = (ListNode*)new ListNode;
    kout[Info] << "enqueue" << (void*)t<<' '<<this << endl;
    t->proc = insertProc;
    rear->next = t;
    t->next = nullptr;
    rear = rear->next;

}

void ProcessQueue::dequeue()
{
    if (isEmpty()) {
        kout[Fault] << "process queue is empty" << endl;
    }
    ListNode* t = front->next;
    kout[Info] << "dequeue" << (void*)t <<' '<<this<< endl;
    front->next = t->next;
    if (rear==t) {
        kout[Info]<<"rear is t"<<endl;
        rear=front;
    }
    delete t;
}

int Semaphore::wait(Process* proc)
{
    bool intr_flag;
    IntrSave(intr_flag);
    lockProcess();
    value--;
    // kout[Info] << "Wait " << proc << endl;
    if (value < 0) {
        kout[Info] << "Wait " << proc<<' '<<proc->name << endl;
        if (!queue.check(proc)) {
            queue.enqueue(proc);
        }
        proc->SemRef++;
        proc->switchStatus(S_Sleeping);
    }

    unlockProcess();
    IntrRestore(intr_flag);

    return value;
}

void Semaphore::signal()
{
    bool intr_flag;
    IntrSave(intr_flag);
    lockProcess();
    kout[Info] << "signal " << endl;
    if (value < 0) {
        kout<<(void *)&queue<<endl; 
        // queue.printAllQueue();
        Process* proc = queue.getFront();
        queue.dequeue();
        proc->SemRef--;
        kout[Info] << "signal " << proc <<' '<<proc->name<< endl;
        if (proc->SemRef == 0) {
            proc->switchStatus(S_Ready);
        }
    }
    value++;

    unlockProcess();
    IntrRestore(intr_flag);
}

int Semaphore::getValue()
{
    bool intr_flag;
    IntrSave(intr_flag);
    lockProcess();
    int re = value;
    unlockProcess();
    IntrRestore(intr_flag);
    return value;
}
