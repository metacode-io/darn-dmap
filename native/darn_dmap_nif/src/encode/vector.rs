use dmap::types::DmapVec;
use rustler::NifTaggedEnum;
use crate::encode::NifSafeFloat;

#[derive(Debug, NifTaggedEnum)]
pub enum NifDmapVec {
    Char(Vec<i8>),
    Short(Vec<i16>),
    Int(Vec<i32>),
    Long(Vec<i64>),
    Uchar(Vec<u8>),
    Ushort(Vec<u16>),
    Uint(Vec<u32>),
    Ulong(Vec<u64>),
    Float(Vec<NifSafeFloat<f32>>),
    Double(Vec<NifSafeFloat<f64>>)
}

impl From<DmapVec> for NifDmapVec {
    fn from(field: DmapVec) -> Self {
        match field {
            DmapVec::Char(c) => NifDmapVec::Char(c.into_iter().collect()),
            DmapVec::Short(c) => NifDmapVec::Short(c.into_iter().collect()),
            DmapVec::Int(c) => NifDmapVec::Int(c.into_iter().collect()),
            DmapVec::Long(c) => NifDmapVec::Long(c.into_iter().collect()),
            DmapVec::Uchar(c) => NifDmapVec::Uchar(c.into_iter().collect()),
            DmapVec::Ushort(c) => NifDmapVec::Ushort(c.into_iter().collect()),
            DmapVec::Uint(c) => NifDmapVec::Uint(c.into_iter().collect()),
            DmapVec::Ulong(c) => NifDmapVec::Ulong(c.into_iter().collect()),
            DmapVec::Float(c) => NifDmapVec::Float(c.into_iter().map(NifSafeFloat::from).collect()),
            DmapVec::Double(c) => NifDmapVec::Double(c.into_iter().map(NifSafeFloat::from).collect())
        }
    }
}