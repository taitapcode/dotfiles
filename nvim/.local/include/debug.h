#ifndef DEBUG_H
#define DEBUG_H

#include <iostream>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <sstream>
#include <cstring>
#include <utility>

template<typename T> std::string _dbg_to_str(const T& v){ std::ostringstream oss; oss << v; return oss.str(); }
inline std::string _dbg_to_str(const std::string& s){ return '"' + s + '"'; }
inline std::string _dbg_to_str(const char* s){ return '"' + std::string(s) + '"'; }
inline std::string _dbg_to_str(char c){ return "'" + std::string(1, c) + "'"; }

template<typename A, typename B> std::string _dbg_to_str(const std::pair<A, B>& p);
template<typename C> std::string _dbg_seq(const C& c, const char* o = "[", const char* e = "]");
template<typename T> std::string _dbg_to_str(const std::vector<T>& v){ return _dbg_seq(v); }
template<typename T> std::string _dbg_to_str(const std::set<T>& s){ return _dbg_seq(s, "{", "}"); }

template<typename K, typename V>
std::string _dbg_to_str(const std::map<K, V>& m) {
    std::string r = "{"; bool f = 1;
    for(auto &kv : m) { if(!f) r += ", "; f = 0; r += _dbg_to_str(kv.first) + ": " + _dbg_to_str(kv.second); }
    return r + "}";
}

template<typename A, typename B>
std::string _dbg_to_str(const std::pair<A, B>& p){ return "(" + _dbg_to_str(p.first) + ", " + _dbg_to_str(p.second) + ")"; }

template<typename C>
std::string _dbg_seq(const C& c, const char* o, const char* e){
    std::string r = o; bool f = 1;
    for(auto &x : c){ if(!f) r += ", "; f = 0; r += _dbg_to_str(x); }
    return r + e;
}

inline void _debug_print(const char* names) {}
template<typename T, typename... R>
void _debug_print(const char* names, T&& v, R&&... r) {
    while(*names == ' ') ++names;
    const char* c = strchr(names, ',');
    if(!c) {
        std::cerr << names << ": " << _dbg_to_str(v);
    } else {
        std::cerr.write(names, c - names) << ": " << _dbg_to_str(v) << ", ";
        _debug_print(c + 1, std::forward<R>(r)...);
    }
}

#define debug(...) std::cerr << "DEBUG: "; _debug_print(#__VA_ARGS__, __VA_ARGS__); std::cerr << std::endl;

#endif
