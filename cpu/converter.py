#!/usr/bin/env python
# encoding: utf-8

import re

if __name__ == '__main__':

    pattern_a = re.compile(r'([a-z0-9]+) = ([a-z0-9]+) \^ ([a-z0-9]+);')

    pattern_b = re.compile(r'([a-z0-9]+) = ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+);')


    pattern_c = re.compile(r'([a-z0-9]+) = ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+);')

    pattern_d = re.compile(r'([a-z0-9]+) = ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+) \^ ([a-z0-9]+);')


    pattern_out = re.compile(r'(out_ptr\[.+\]) = ([a-z0-9]+) \^ (in_ptr\[.+\]);')

    with open("ec-gf.c") as file:
        with open("ec-xor.c","w+") as out:
            for line in file:
                if pattern_a.search(line):
                    m = pattern_a.search(line)
                    new_line = 'XOR3({0},{1},{2});\n'.format(m.group(1),m.group(2),m.group(3))
                    out.write(new_line)
                    print new_line
                elif pattern_b.search(line):
                    m = pattern_b.search(line)
                    new_line = 'XOR4({0},{1},{2},{3});\n'.format(m.group(1),m.group(2),m.group(3),m.group(4))
                    out.write(new_line)
                    print new_line
                elif pattern_c.search(line):
                    print 'FOUND!'
                    m = pattern_c.search(line)
                    new_line = 'XOR5({0},{1},{2},{3},{4});\n'.format(m.group(1),m.group(2),m.group(3),m.group(4),m.group(5))
                    out.write(new_line)
                    print new_line
                elif pattern_d.search(line):
                    print 'NO!!!'
                elif pattern_out.search(line):
                    m = pattern_out.search(line)
                    new_line = 'XOR3({0},{1},{2});\n'.format(m.group(1),m.group(2),m.group(3))
                    out.write(new_line)
                    print new_line
                else:
                    out.write(line)
                    print line

