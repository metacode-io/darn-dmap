use dmap::types::DmapField;
use rustler::NifTaggedEnum;
use crate::encode::{NifDmapScalar, NifDmapVec};

#[derive(Debug, NifTaggedEnum)]
pub enum NifDmapField {
    Vector(NifDmapVec),
    Scalar(NifDmapScalar),
}

impl From<DmapField> for NifDmapField {
    fn from(field: DmapField) -> Self {
        match field {
            DmapField::Vector(v) => NifDmapField::Vector(v.into()),
            DmapField::Scalar(s) => NifDmapField::Scalar(s.into()),
        }
    }
}