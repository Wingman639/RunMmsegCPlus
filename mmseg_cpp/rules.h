#ifndef _RULES_H_
#define _RULES_H_

#include <vector>
#include <algorithm>

#include "chunk.h"
#include <iostream>
namespace rmmseg {
template <typename Cmp>
void take_highest(std::vector<Chunk> &chunks, Cmp &cmp) {
    unsigned int i = 1, j;
    Chunk& max = chunks[0];
    for (j = 1; j < chunks.size(); ++j) {
        int rlt = cmp(chunks[j], max);
        if (rlt > 0)
            i = 0;
        if (rlt >= 0)
            std::swap(chunks[i++], chunks[j]);
    }
    chunks.erase(chunks.begin()+i, chunks.end());
//    for (j = 0; j < chunks.size(); ++j) {
        //std::cout<<"chunks ";
//        for (unsigned k=0;k<3;++k) {
            //std::cout<<chunks[j].words[k]->text<<" ";
//        }
        //std::cout<<"\n";
//    }
}

struct MMCmp_t {
    int operator()(Chunk &a, Chunk &b) {
        return a.total_length() - b.total_length();
    }
} MMCmp;
void mm_filter(std::vector<Chunk> &chunks) {
    //std::cout<<"length"<<"\n";
    take_highest(chunks, MMCmp);
}

struct LAWLCmp_t {
    int operator()(Chunk &a, Chunk &b) {
        double rlt = a.average_length() - b.average_length();
        if (rlt == 0)
            return 0;
        if (rlt > 0)
            return 1;
        return -1;
    }
} LAWLCmp;
void lawl_filter(std::vector<Chunk> &chunks) {
    //std::cout<<"avg_length"<<"\n";
    take_highest(chunks, LAWLCmp);
}

struct SVWLCmp_t {
    int operator()(Chunk &a, Chunk& b) {
        double rlt = a.variance() - b.variance();
        if (rlt == 0)
            return 0;
        if (rlt < 0)
            return 1;
        return -1;
    }
} SVWLCmp;
void svwl_filter(std::vector<Chunk> &chunks) {
    //std::cout<<"variance"<<"\n";
    take_highest(chunks, SVWLCmp);
}

struct LSDMFOCWCmp_t {
    int operator()(Chunk &a, Chunk& b) {
        //std::cout<<"free"<<"\n";
        //std::cout<<"degree a"<<a.degree_of_morphemic_freedom();
        //std::cout<<" degree b"<<b.degree_of_morphemic_freedom();

        return a.degree_of_morphemic_freedom() - b.degree_of_morphemic_freedom();
    }
} LSDMFOCWCmp;
void lsdmfocw_filter(std::vector<Chunk> &chunks) {
    take_highest(chunks, LSDMFOCWCmp);
}
}

#endif /* _RULES_H_ */
