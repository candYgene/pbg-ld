#
# Update chromosome names in *.db files (use integers [0-12]).
#

# S. lycopersicum
cp ITAG2.4_gene_models.db{,.org}
cp ITAG2.4_sgn_data.db{,.org}
cp ITAG2.4_solCAP.db{,.org}

sqlite3 ITAG2.4_gene_models.db "update features set seqid=cast(replace(seqid, 'SL2.50ch', '') as number)"
sqlite3 ITAG2.4_sgn_data.db "update features set seqid=cast(replace(seqid, 'SL2.50ch', '') as number)"
sqlite3 ITAG2.4_solCAP.db "update features set seqid=cast(replace(seqid, 'SL2.50ch', '') as number)"

# S. pennellii
cp spenn_v2.0_gene_models_annot.db{,.org}
cp sgnMarkersSpenn.db{,.org}

sqlite3 spenn_v2.0_gene_models_annot.db "update features set seqid=cast(replace(seqid, 'Spenn-ch', '') as number)"
sqlite3 sgnMarkersSpenn.db "update features set seqid=cast(replace(seqid, 'Spenn-ch', '') as number)"

# Solanum tuberosum
cp PGSC_DM_V403_genes.db{,.org}
cp PGSC_DM_V403_DArT.db{,.org}
cp potato_69011SNPs_potato_dm_v4.03.db{,.org}

sqlite3 PGSC_DM_V403_genes.db "update features set seqid=cast(replace(seqid, 'ST4.03ch', '') as number)"
sqlite3 PGSC_DM_V403_DArT.db "update features set seqid=cast(replace(seqid, 'ST4.03ch', '') as number)"
sqlite3 potato_69011SNPs_potato_dm_v4.03.db "update features set seqid=cast(replace(seqid, 'chr', '') as number)"
