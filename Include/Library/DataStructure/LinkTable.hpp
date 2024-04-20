#ifndef POS_LINKTABLE_HPP
#define POS_LINKTABLE_HPP

#define DoNothing 0

namespace POS{
	template <class T> class LinkTableT{//伪头结点;基类
		protected:
			T *pre,
			  *nxt;//双向链表
			
		public:
			inline T* This()
			{return (T*)this;}//返回当前结点指针
			
			inline void PreInsert(T *p){//头插
				if (pre==nullptr){
					p->nxt=This();
					pre=p;
				}
				else{
					p->pre=pre;
					p->nxt=This();
					pre->nxt=p;
					pre=p;
				}
			}
			
			inline void NxtInsert(T *p){//尾插
				if (nxt==nullptr){
					p->pre=This();
					nxt=p;
				}
				else{
					p->pre=This();
					p->nxt=nxt;
					nxt->pre=p;
					nxt=p;
				}
			}
			
			inline void Remove(){
				if (pre==nullptr&&nxt==nullptr)
					DoNothing;
				else if (pre==nullptr){
					nxt->pre=nullptr;
					nxt=nullptr;
				}
				else if (nxt==nullptr){
					pre->nxt=nullptr;
					pre=nullptr;
				}
				else{
					pre->nxt=nxt;
					nxt->pre=pre;
					pre=nxt=nullptr;
				}
			}
			
			inline bool Single() const
			{return pre==nullptr&&nxt==nullptr;}
			
			inline bool PreEmpty() const
			{return pre==nullptr;}
			
			inline bool NxtEmpty() const
			{return nxt==nullptr;}
			
			inline T* Pre()
			{return pre;}
			
			inline T* Nxt()
			{return nxt;}
			
			inline void Init()
			{pre=nxt=nullptr;}
	};
	
	template <class T> class LinkTable{
		protected:
			LinkTable <T> *pre=nullptr,
						  *nxt=nullptr;
			T *data=nullptr;
			
		public:
			inline T* Data()
			{return data;}
			
			inline T* operator () ()
			{return data;}
			
			inline void PreInsert(LinkTable <T> *p){
				if (pre==nullptr){
					p->nxt=this;
					pre=p;
				}
				else{
					p->pre=pre;
					p->nxt=this;
					pre->nxt=p;
					pre=p;
				}
			}
			
			inline void NxtInsert(LinkTable <T> *p){
				if (nxt==nullptr){
					p->pre=this;
					nxt=p;
				}
				else{
					p->pre=this;
					p->nxt=nxt;
					nxt->pre=p;
					nxt=p;
				}
			}
			
			inline void Remove(){
				if (pre==nullptr&&nxt==nullptr)
					DoNothing;
				else if (pre==nullptr){
					nxt->pre=nullptr;
					nxt=nullptr;
				}
				else if (nxt==nullptr){
					pre->nxt=nullptr;
					pre=nullptr;
				}
				else{
					pre->nxt=nxt;
					nxt->pre=pre;
					pre=nxt=nullptr;
				}
			}
			
			inline bool Single() const
			{return pre==nullptr&&nxt==nullptr;}
			
			inline bool PreEmpty() const
			{return pre==nullptr;}
			
			inline bool NxtEmpty() const
			{return nxt==nullptr;}
			
			inline LinkTable <T>* Pre()
			{return pre;}
			
			inline LinkTable <T>* Nxt()
			{return nxt;}
			
			inline void SetData(T *_data)
			{data=_data;}
			
			inline void Init()
			{pre=nxt=nullptr;}
	};
};

#endif
