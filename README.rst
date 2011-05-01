Flash Card Decks for studying for the FCC Amateur Radio exams. Also
included are the scripts I used to generate them from the original
NCVEC Question Pool sources.

Inspired by the old mnemosyne decks posted by Kelly Martin:
http://nonbovine-ruminations.blogspot.com/2009/01/mnemosyne-study-decks-for-fcc-amateur.html


To use these XML decks you need Mnemosyne installed on your
system. It's free, written in Python (so it runs on Windows/Mac OS
X/Linux), and uses an algorithm to help you spend more time on the
questions you really need to study.


The decks are in the "decks" folder. Those are the only things you
need to import into Mnemosyne. Everything else is just what I used to
generate them.


Generating the decks
====================
Ok, generating the decks wasn't a 100% automated process.

The RNC XML DTD on the Mnemosyne site wanted to make every attribute a
required one but that made validating new decks impossible. I modified
the DTD to make the <item> attributes optional.

I deleted the header and footer content from the NCVEC question
pools. Also, since the text files were Windows-1252 encoded (fancy
hyphens and smart quotes) I had to convert them to plain ASCII. I used
Libre Office for that. All of this was just to make the question pools
easy to parse.



External Resources
==================

Mnemosyne
---------
http://www.mnemosyne-proj.org/

A free sophisticated flash-card tool which optimizes your learning
process.


ARRL Question Pools
-------------------
http://www.arrl.org/question-pools/

The single place to go for the latest FCC question pools.
