# r-singlecell

A reproducible R environment for single-cell and bioinformatics workflows.

## Apple Container

Install [Apple Container](https://github.com/apple/container/releases) using the signed `.pkg`.

Pull the image:

```zsh
container image pull ghcr.io/umehina/r-singlecell:latest
```

Start an interactive R session:

```zsh
container run --rm -it ghcr.io/umehina/r-singlecell:latest R --vanilla
```

## Included packages

- Core single-cell / Seurat
  - `Seurat`, `SeuratObject`, `SingleCellExperiment`, `SummarizedExperiment`, `scater`, `scran`, `scuttle`, `batchelor`, `glmGamPoi`, `beachmat`
- Large / disk-backed matrices
  - `BPCells`, `HDF5Array`
- Trajectory analysis
  - `monocle3`, `SeuratWrappers`
- Cell-cell communication
  - `CellChat`, `NMF`, `circlize`, `ComplexHeatmap`
- Functional enrichment / annotation
  - `clusterProfiler`, `org.Mm.eg.db`, `GenomicRanges`
- Differential expression / ranking
  - `presto`
- Data wrangling and visualization
  - `tidyverse`, `ggplot2`, `dplyr`, `tibble`, `patchwork`, `cowplot`, `ggnewscale`, `spatstat.explore`, `readxl`, `openxlsx`, `tiff`
- Supporting packages
  - `R.utils`, `SeuratData`

Additional packages are installed automatically as dependencies.