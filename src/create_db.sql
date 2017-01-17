CREATE TABLE uniprot (chr TEXT, gene TEXT, alt_gene TEXT, des TEXT);
CREATE TABLE tgrc (gene TEXT, des TEXT, phen TEXT, chr TEXT);

-- Note: expression-based indices require SQLite > v3.9.x
-- CREATE INDEX idx_uniprot_chr_norm_gene on uniprot(chr, upper(replace(gene, '-', '')));
-- CREATE INDEX idx_uniprot_chr_norm_alt_gene on uniprot(chr, upper(replace(alt_gene, '-', '')));
-- CREATE INDEX idx_tgrc_chr_norm_gene on tgrc(chr, upper(replace(gene, '-', '')));

.sep \t
.import ../data/tgrc/uniprot.tsv uniprot
.import ../data/tgrc/tgrc.tsv tgrc

DELETE FROM uniprot WHERE chr = 'chr';
DELETE FROM tgrc WHERE chr = 'Chromosome';
UPDATE uniprot SET alt_gene = NULL WHERE alt_gene = '';
UPDATE tgrc SET phen = NULL WHERE phen = ' ';
