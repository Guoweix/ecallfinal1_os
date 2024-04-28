#include <Synchronize/Synchronize.hpp>

#include "Library/KoutSingle.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"

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
    front = (ListNode*)slab.allocate(sizeof(ListNode));
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
        slab.free(t, sizeof(ListNode));
    }
}

Process*
ProcessQueue::getFront()
{
    if (isEmpty()) {
        kout[Fault] << "process queue is empty" << endl;
    }

    return front->next->proc;
}

void ProcessQueue::enqueue(Process* insertProc)
{
    ListNode* t = (ListNode*)slab.allocate(sizeof(ListNode));
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
    front->next = t->next;
    slab.free(t, sizeof(ListNode));
}

int Semaphore::wait(Process* proc)
{
    bool intr_flag;
    IntrSave(intr_flag);
    lockProcess();
    value--;
    if (value < 0) {
        queue.enqueue(proc);
        proc->SemRef++;
        proc->switchStatus(S_Sleeping);
    }

    unlockProcess();
    IntrRestore(intr_flag);

    return value;
}

void Semaphore::signal(Process* proc)
{
    bool intr_flag;
    IntrSave(intr_flag);
    lockProcess();
    if (value < 0) {
        Process* proc = queue.getFront();
        queue.dequeue();
        proc->SemRef--;
        if(proc->SemRef==0)
        {
            proc->switchStatus(S_Ready);
        }
    } 
    value++;

    unlockProcess();
    IntrRestore(intr_flag);
}