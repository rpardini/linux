import sys,re
def p(m):
    v=int(m.group(1)); return 'poc=%d/%d'%(v-65536 if v>=65536 else v, int(m.group(2))-65536 if int(m.group(2))>=65536 else int(m.group(2)))
for l in open(sys.argv[1]):
    if not l.startswith('DP'): continue
    l=re.sub(r'poc=(-?\d+)/(-?\d+)',p,l.split(' ',2)[2].rstrip())
    head,_,dpb=l.partition('|'); print(head+'| '+' '.join(sorted(re.findall(r'\[[^]]*\]',dpb))))
