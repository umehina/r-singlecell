# r-singlecell

R and Bioconductor environment for single-cell and bioinformatics workflows.

The image is based on [`bioconductor/bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker) and includes commonly used packages for Seurat workflows, trajectory analysis, cell-cell communication, enrichment analysis, and visualization.

## Quick start

On macOS devices only:

```bash
# install podman (refer to official podman documentation)
# replace `podman` with `docker` or `container` as appropriate.
brew install podman

# use more cpus and memory for heavy analysis.
podman machine init --cpus 8 --memory 32768 --disk-size 32
podman machine start
```

Pull the image:

```bash
podman pull ghcr.io/umehina/r-singlecell:latest
```

Start an RStudio session:

```bash
podman run -d \
  --name r-singlecell \
  -c 8 -m 32g \
  -p 8787:8787 \
  -e PASSWORD='some_password' \
  -v "/path/to/data:/workspace" \
  ghcr.io/umehina/r-singlecell:latest
```

RStudio will be available on your web browser at `http://localhost:8787`. 

When the image is run with rootless Podman, the Rocker/Bioconductor startup scripts may configure RStudio to use:

```text
Username: root
Password: <value passed with PASSWORD>
```

For more information, refer to the [Bioconductor/bioconductor_docker](https://github.com/Bioconductor/bioconductor_docker) repository. 

To start an interactive R session:

```bash
podman run --rm -it \
  ghcr.io/umehina/r-singlecell:latest \
  R --vanilla
```

To check the R version:

```bash
podman run --rm \
  ghcr.io/umehina/r-singlecell:latest \
  R --version
```

To check the RStudio Server version:

```bash
podman run --rm \
  ghcr.io/umehina/r-singlecell:latest \
  rstudio-server version
```

To check whether an R package is installed:

```bash
podman run --rm \
  ghcr.io/umehina/r-singlecell:latest \
  R -q -e 'packageVersion("Seurat")'
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

## Acknowledgements

Thanks to the [Bioconductor/bioconductor_docker](https://github.com/Bioconductor/bioconductor_docker) project for providing the `bioconductor` container upon which this project is based.