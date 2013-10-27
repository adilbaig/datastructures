import std.stdio, std.random, std.conv;

struct Bucket {
    size_t value;
    Bucket* next;
    
    string toString() {
        if(next == null)
            return to!(string)(value);
        
        size_t[] values = [value];
        
        Bucket* b = next;
        do{
            values ~= (*b).value;
            b = b.next;
        }while(b != null);
        
        return to!(string)(values);
    }
}

Bucket[50] vals;
size_t vp;

Bucket* getLast(Bucket* b)
{
    if(b.next != null)
        return getLast(b.next);
        
    return b;
}

size_t hash_function(string key, size_t length)
{
    size_t i, nkey;
    
//    writeln(key);
    foreach(uint k; key) {
        nkey = nkey * 2 + k;
//        writeln(k, ",", nkey);
    }
        
    return nkey % length;
}

void main()
{
    Bucket[97] hashtable;
    
    //I am simulating hash collisions by adding many 'Adil's
    string[] keys = ["Adil", "Abdul", "Iftikhan", "Rasmus", "Adil1", "lidA", "Adil"];
    foreach(k ; keys){
        auto pos = hash_function(k, hashtable.length);
        writeln(k, " : ", pos);
        
        vals[vp] = Bucket(uniform(100, 200), null);
        writeln(vals);
        
        if(hashtable[pos].value != 0) {
            Bucket* b = getLast(&(hashtable[pos]));
            (*b).next = &vals[vp];
        } else {
            hashtable[pos] = vals[vp];
        }
        
        vp++;
    }
    
    writeln(hashtable);
}