#include <Library/KoutSingle.hpp>
#include <Synchronize/Sigaction.hpp>

void SigactionQueue::printAllQueue()
{
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    ListNode_siga* nxt = front->next;

    while (nxt != nullptr) {
        showSigaction(nxt->siga);
        nxt = nxt->next;
    }
}

void SigactionQueue::init()
{
    // front = (ListNode*)slab.allocate(sizeof(ListNode));
    front = new ListNode_siga;

    rear = front;
    if (front == nullptr)
        kout[Fault] << "process Queue Init Falied" << endl;
    front->next = nullptr;
}

bool SigactionQueue::isEmpty()
{
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    return front == rear;
}

int SigactionQueue::length()
{
    int re = 0;
    if (front == nullptr) {
        kout[Fault] << "queue isn\'t init" << endl;
    }

    ListNode_siga* nxt = front->next;

    while (nxt != nullptr) {
        re++;
        nxt = nxt->next;
    }
    return re;
}

void SigactionQueue::destroy()
{
    ListNode_siga* nxt = front;

    while (nxt != nullptr) {
        ListNode_siga* t = nxt;
        nxt = nxt->next;
        delete t;
    }
}

sigaction* SigactionQueue::getFront()
{
    // kout<<Yellow<<"getFront"<<endl;
    if (isEmpty()) {
        kout[Fault] << "process queue is empty" << endl;
    }
    // kout<<Yellow<<"getFront"<<front->next<<endl;

    return front->next->siga;
}

bool SigactionQueue::check(sigaction* _check)
{

    ListNode_siga* nxt = front->next;

    while (nxt != nullptr) {
        if (nxt->siga == _check) {
            return true;
        }
        nxt = nxt->next;
    }
    return false;
}

void SigactionQueue::enqueue(sigaction* insertProc)
{
    ListNode_siga* t = (ListNode_siga*)new ListNode_siga;
    kout[Info] << "enqueue" << (void*)t << ' ' << this << endl;
    t->siga = insertProc;
    rear->next = t;
    t->next = nullptr;
    rear = rear->next;
}

void SigactionQueue::dequeue()
{
    if (isEmpty()) {
        kout[Fault] << "process queue is empty" << endl;
    }
    ListNode_siga* t = front->next;
    kout[Info] << "dequeue" << (void*)t << ' ' << this << endl;
    front->next = t->next;
    if (rear == t) {
        kout[Info] << "rear is t" << endl;
        rear = front;
    }
    delete t;
}

void showSigaction(sigaction* t)
{
    kout[Info] << t->sa_sigaction << endl
               << t->sa_flags << endl
               << t->sa_handler << endl
               << t->sa_mask << endl;
}