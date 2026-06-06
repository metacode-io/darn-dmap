use dmap::types::DmapScalar;
use rustler:: NifTaggedEnum;
use crate::encode::NifSafeFloat;

#[derive(Debug, NifTaggedEnum)]
pub enum NifDmapScalar {
    Char(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Uchar(u8),
    Ushort(u16),
    Uint(u32),
    Ulong(u64),
    Float(NifSafeFloat<f32>),
    Double(NifSafeFloat<f64>),
    String(String)
}

impl From<DmapScalar> for NifDmapScalar {
    fn from(field: DmapScalar) -> Self {
        match field {
            DmapScalar::Char(c) => NifDmapScalar::Char(c),
            DmapScalar::Short(c) => NifDmapScalar::Short(c),
            DmapScalar::Int(c) => NifDmapScalar::Int(c),
            DmapScalar::Long(c) => NifDmapScalar::Long(c),
            DmapScalar::Uchar(c) => NifDmapScalar::Uchar(c),
            DmapScalar::Ushort(c) => NifDmapScalar::Ushort(c),
            DmapScalar::Uint(c) => NifDmapScalar::Uint(c),
            DmapScalar::Ulong(c) => NifDmapScalar::Ulong(c),
            DmapScalar::Float(c) => NifDmapScalar::Float(NifSafeFloat::from(c)),
            DmapScalar::Double(c) => NifDmapScalar::Double(NifSafeFloat::from(c)),
            DmapScalar::String(c) => NifDmapScalar::String(c)
        }
    }
}