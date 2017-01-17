.mode list
.sep \t
.header on
.output tgrc-uniprot.tsv

SELECT *
FROM (
   SELECT A.gene gene1, A.des des1, A.chr chr1, phen phen1, B.gene gene2, B.alt_gene alt_gene2, B.des des2, B.chr chr2
   FROM tgrc A, uniprot B
   WHERE A.chr = B.chr AND upper(replace(A.gene, '-', '')) = upper(replace(B.gene, '-', ''))
   UNION
   SELECT A.gene gene1, A.des des1, A.chr chr1, phen phen1, B.gene, B.alt_gene alt_gene2, B.des des2, B.chr chr2
   FROM tgrc A, uniprot B
   WHERE A.chr = B.chr AND upper(replace(A.gene, '-', '')) = upper(replace(B.alt_gene, '-', ''))
) WHERE phen1 IS NOT NULL;
