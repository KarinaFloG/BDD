
define p_sys_pwd='&1'
define p_pdb='&2'
define p_usr='&3'
define p_pwd='&4'
define p_tipo_fr='&5'
define p_num_sitio ='&6'

Prompt Iniciando validacion para &&p_pdb. 

!rm -rf /tmp/bdd/p7
!mkdir -p /tmp/bdd/p7
!dd if=/dev/urandom of=/tmp/bdd/p7/p7-sample-1.bin bs=1 count=0 seek=1M
!dd if=/dev/urandom of=/tmp/bdd/p7/p7-sample-2.bin bs=1 count=0 seek=2M
!dd if=/dev/urandom of=/tmp/bdd/p7/p7-sample-3.bin bs=1 count=0 seek=3M
!dd if=/dev/urandom of=/tmp/bdd/p7/p7-sample-4.bin bs=1 count=0 seek=4M
!dd if=/dev/urandom of=/tmp/bdd/p7/p7-sample-5.bin bs=1 count=0 seek=5M


connect sys/&&p_sys_pwd@&&p_pdb as sysdba

create or replace directory bdd_p7_dir as '/tmp/bdd/p7';
grant read,write on directory bdd_p7_dir to &&p_usr; 

Prompt Iniciando creacion de procedimientos para &&p_pdb
connect &&p_usr/&&p_pwd@&&p_pdb


@s-00-funciones-validacion.plb
@s-00-load-blob-from-file.sql

create or replace procedure spv_valida_sinonimos wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
584 30e
ZqCosvynFMduk2xXJazF182IXHwwg/DD10qDfC+5iPS/dROTKqNiMeWNb1J8r47E9HkxoStu
2MPZ+/QClDj+27qB85LgMn5Jf1Zz9+N6M3j5yYsTf+abRkeZoQ4/QusgPZ9OwykjAwW733L4
IxT13ESxmb1sp/rT2Ves7qZnESuRo7NuwHw8X4X9DuU17GTSFoZfyXFC0Mx2VVVZ4o/sFjUU
QQ8I9Z0ayBjZyb1aTFem6QnxXd0XmkdRiP9aGsBuHxyHWkE1a+N3/2osJNH0JjEPl+qsWfej
iPxcQG4dyU7IthbW94SmyN3DKX8YbvOMTYTJdWxo5v+ef1whAo93FVUb0spYWvTzFSP1E1Dv
PufZLTWQOKTtiP6LECA/ntEXNBqIKsZoj3PU8TYFzs8Su5Tee2V2R4Xql+IqOjiev2EXmevF
MX0yGWSJx+7j4mg0epLnC/3X31SJq9Xrr88UIEz2sE3bPpATenOD4fPl0D0IDUCwgW+Dfz+m
d/KmuHv6BQ5kqKlwAwOWj3OyxrnJJddT2Qxal8DXndBp/XRQAee/CjrjWCZgOQ+rTG4kGj5f
qA/Tn1xjj/cE7dQPVj6hjaitweO1E4bH2TWSrJtjXdDsWvoBJLkBDVUse1KPY3vDSxIQhywz
YBfvTlK2xZ97RL2BjIaXsJkPz1A92YuutW6/0tBFUZnb+O+Lws3yS974JK3q0JAfXlq6xpjF
SBtQi1Uyc5bhxFZNvdIesG2gtVJxu1nkq5PpQB3v+l1qIG2UEbw=

/
show errors

create or replace procedure spv_valida_vistas wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
423 28c
Up0RC5ogkqJJxxBvl3Jo8cbpTL4wgwK310qDfC+pEofemjhIyyego1Ogo9uvFLcG3y1iBfrl
SdXFdshhaWKJ67xZD4yxEC2DLWs5ksfj1IY6gXi2JqI3AQovn5rLM1AkO5ztANi/+D9bWKBA
oTjVRKRclazlocvEeKYlm2Et7Igb3ZCLTWDdoMSOOyXmQjja6LI9CBxnC/AC+3+1fUZDoK92
btbejO0JUTcrjMKv6WqG4Uy6f93Pp+eCJX/PFKipm2XXOV8Xr6ZnFAHsXUky3EKo00zEvK6j
Seq0haveWCOUYsCEYkqhP3uu3MHbLfOk9nWYjq+tPUktBbN32UimeMj0j8KhP6oB628NoukM
xrtoeUosBP4ZnDEcybgkGiZ2P0NwGoJNAshr8G3IwxCZC5zKywyfpyd4dLcmmHxsxkE82PVy
bZsRztevYtf5+Mun1TD8OLRrW8qA1d3ZbUUMOaer59h4arl5ZGbm97OT9gl/SNjOifdrnsht
d/tNtVBi9KoQdBc9Mbn/cHTJN+QYLnumBylzyCj28LVOz3gAKwFc2FhLWVJy+fFster0er7/
vapzOjKBNIGKh6owMBwQzr+hZ7g5HnI+AOTOnWTfD2ETc8edXwjEeLmo63idpif3ma8=

/
show errors

create or replace procedure spv_crea_tablas_temporales wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
2b7 1a9
qOTBITAsEbXpPFHRi9Xzs/BXQPAwg5DMcvbWfI4ZvlC17lXlj69Cq9Kg3hECK21cPBOi10Wp
7C9eOLVzh8lFvdXWgdNPmtn4PzR2wiEUzPfzBF1UPBizCevlY4Qmk0kCUWL9yiIVwAjm31Ks
mkPhjwrfRKat90uFvdv4APQGF9gr8NPTdJkd1zlMPB889kWjE/vAnvqo0F7ac0VsvRo6p5GA
3etRpqEtBS7+txF5qaH+QHUt2Ihuusyzb9jegQi6mlhTsE/xeFAPRRg+wbP+z7EDLrP26Q2p
nindcOItc7WFkARCxsyhaCz4+d0k/N8hYJA3eLe17afcxYkezLF+1BUg2D+wxxk58DFBiwlH
uqnqjc1SC4gm4vKuh7hcJ7Rp1dH20SMEJmWEN7bOvLs/JECT12pJ14aVLg==

/
show errors

exec spv_crea_tablas_temporales



create or replace procedure spv_prepara_datos wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
14d9 625
U708g+Qslj/A3uSebhCe/zrRjfIwg0NUVUiMV44ZHveLpM9b91qRdKAu5b58j6C54WA5ZT1o
DooUmLYmKaLXERr3kiv4507gx3QUUDZlBYobCj3f57V2z/8ICMFyxvBjpXVPoUA8CmQ6/N68
7CIuTjHS2cENHME+0OkipxHmY78MbCmoQTQQ1lAUvx3uZoFFP/jUAXh6CVWlTRUX+wyIqwzz
UWlZMIWTiRhoNCLKFAdGb+e/lYc5ZoNRoNPI0Tc9bEu62BRYnPpGOWKfYWYlZUoCUt1Nmt8p
O015bgzvZHlpMZrfZuh63ohp9Zx/Edh0enrydVlrWukqK5aeuf2HZ0lH46J98snPL/PXWEkO
+gCD1UCuEcgtNinoawL+qzS0AP42w0081VnNPklk6tx0zUrUowhv84lIazSVc8VUI5O5tH1c
no0D4m0tYyEmKMwxg79TGAiudzcSoaxiwlzqYXtxfqY1mis1MpRbq8F/LlhfRuVAXFwpNRFW
4dHAKMMIfzb6hmZlubR1r6XtPVPZTRjDyuAzNY3DCdfjwsoWh/2a7Eo9FnpYDy8+0JdnFOlN
nsZ9LtRjkWn94Fl8PHQDiFN/5T7BpCXgsmPEVuZjVej+gWF3xFxDEG+LE2EtTNSy4SB1RhCH
zpMnoiqiWV+yXnPyVG537AFUcPDkd6s6gNjz1o7H1pt0PH5q0Ysrk14JbxSYmR6nmRLlWk/H
XHKIQ8cGwY8jwpsTFEFdKTuOu8cbY8hFp0csiywk0by1OuPJx9L469LQQ+QI2aCKk3o/kCJW
yU/3HCSY7fMlQU/EDhbBr2YsV4+rDWUpizSxChjs09CydfCWq3Eg05nPn+JAM6lU+Ha1nKAv
amFaNxxbhjfHs6/NPgwlNHfraVsHo8XexSMqlKy6Nw4/94JD/PX/xnpwRYuSPxwPiyKcZ+MK
2fkjRXEAR/iLj8SVjDz2C80uSOsBKDw2wKaW6fibGDRcSFC4du2dAo1kJIC7R5eKCANsZOxi
OuoXuhdapAeulF/fndgb43C/jWKMUMw9/f24nBOg1V+WfGE9qE06o/iHGZHoqmrTPv+D2eHZ
cN5RpHCLSOD50K4x4ueLXXcC311cCOkFG+WW31rqXgoFYADBf9aZ6l7DkkwEedKbfG9lAUBy
066bU1rUevPUCaaVsIpsvVg5aGPPWov1shMQMEfulGDoAMBu9wHmGskD+cAxtTmqfetJ4NCn
bbMjO4EYlcXND62cYR2JERF/7fNaQ8f3Bv/w5CramuK/IoNVktf2hpOsw3/69C4mNSo+PYbD
qvoulqSmZmXzRH4qFplYgVL1BIfBoh8xgB+v6NZZZRUwkXtbUFyDKwTWc/x0ljnbJo9DFUTz
NyokTgki7iKB0K9YgZtGKWCrrQzdStSDzBEe1LpJBoUI49rVa5PIjbmEueFYavOfYLQiohHA
HRS6TIRbb3aI8WNxno58Wsov1yWMV9cp/8nstXKSql7sDVt8CR10wwd6At+Y/lRurA3yXkY2
XRtl3pEWCTY3DO0PCiHmFQFAJvf3qnPZKJnU5tA=

/
show errors 


create or replace procedure spv_consulta_datos wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
11e0 573
CG98dEA3A1bVPVzQBCC0FigpoSAwgzsrVUiMV44ZHveLpP+kkaNc1r8z6MzR0wZhEWrQ3fUX
4si3MLoU4fPIcYEBi4gz84uVPHVPyNtng6FjGkrQcsFOkCQsxg0yev5MdDGfLNjxVwXprbI8
Ia5lPb1WmnR61gTfpT10mO98NHJPpkEC21irh2wELJ8XXgzEcsQAD/5MIEVXnH0iYYXSz5qg
T7Lrj2W9q9+QREH/0BSVwbfOxdwpYSlT33hAj3A3O4CbjjAk2DM64gtUmH2O5a5ceL9u79/e
tyIqJWa5ibRzbxxP9+y/wDayHK2C9kAssgqfjAcfVEkOBbzpd5Z6/OkvozWquHm2GD0wj/W2
MmvMtaslJ1HVoPwPhKNcHL2QwAAas5d8azLOABqTG75p09kDNtj1AJrDwYLrmW8zirnztyX4
J6TwzB3F+kbhKYlZAkh6Z5hXSQ77QhXmhIX7pb/Y+DbWOOwwSFk68j5jiG20xQd+xMyx2S5v
ovqbuQJD820Pm+qNv6l6Q5VyspmGejf4zQor/HMTG/1UzVRHBR3ridGYLStsOj3NZ9PaacSk
TcIdlnpowoCjrv62QjbUT5j1aZ1KU7TsTleQieRpoyHNjJCI8cs9XdSoASjinRkA5xofa5d/
uD0Fgz6qw/SV4t0NEAbOXUqqrAI4OFxSMQx1Q97x+23ZiZMfHtff4CGHSUvBCew+jBsWQU52
V9HEqEu1K5S4EXUtdJGq/g407aSjh71SUSKM5Dw1MrPKYAsxcxlIDQyCq4Edd3m3C1qTfVGr
QEcWmOOJW2/Lhvn8RE34S44VWTPuG5HpOzNndhV7/PAeZvQPFc/Eiy2TglSz16eYQtTr8iaB
3OJJof/tV4YuNvw8Us+YGgljepFnWR77FYNDV00oW7KGfmHewhpS/0q4kQLSHFbcZP0e0yNi
FndbAmBJIFT2UXXd6ktMTZKX+qXKtqeWpTZGfVolWSi3x5Mq74WmumpnqED86WJyjtL6t/a1
tnCxDUxc87W5rwvIVk5VIu6r3utfU/b8zHs7QdqpxHhEZuxcACnLcdTqIUMSL5S6aTB8sreg
+lIpmSUqlwj+WvgYvBDzD+WfXq2YqlYAK5JOiwXXD83hEyMcn/TFT15JTOho5rEDkxhjuMRj
SuEyKYTRCV+cJC7qZO5BmDKI1InaFobvr/mxchZxXrQlieFtl2+zw+zA8735pQ/3HTwi8jXU
qR9DAhRQXKEOHvFnpHOSdmhYJJGks9hJYJOxjqJ7dj33Trf/KYYzj9G+uc2pi7vJIOtajQpp
Jwmb7V8iQdlMRiObOpBuUICtax7HktfSIsqkAVNujeToF6sC9ZT5kpbRlwGUzVOVjczkgQS1
CCR4qrkA

/
show errors

exec spv_print_header
host sha256sum &&p_script_validador
exec spv_prepara_datos(trim(upper('&&p_tipo_fr')));
exec spv_valida_sinonimos(trim(upper('&&p_tipo_fr')),&&p_num_sitio);
exec spv_valida_vistas(trim(upper('&&p_tipo_fr')),&&p_num_sitio);
exec spv_consulta_datos(&&p_num_sitio);

