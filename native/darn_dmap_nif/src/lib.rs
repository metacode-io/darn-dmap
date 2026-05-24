use dmap::{DmapRecord, Record};
use dmap::types::{DmapField, DmapScalar, DmapVec};

use rustler::{Encoder, Env, NifMap, NifResult, Term};

#[rustler::nif]
fn read_records(path: String) -> NifResult<usize> {
    let records = dmap::DmapRecord::read_file(path)
        .map_err(|e| rustler::Error::Term(Box::new(e.to_string())))?;

    Ok(records.len())
}

// #[rustler::nif]
// fn read_file<'a>(env: Env<'a>, path: String) -> Result<Term<'a>, String> {
//     let records = DmapRecord::read_file(path)
//         .map_err(|err| err.to_string())?;

//     let encoded_records: Vec<Term<'a>> = records
//         .into_iter()
//         .map(|record| encode_record(env, record.inner()))
//         .collect();

//     Ok((rustler::atoms::ok(), encoded_records).encode(env))
// }

// fn encode_record<'a>(
//     env: Env<'a>, 
//     record: indexmap::IndexMap<String, DmapField>,
// ) -> Term<'a> {
//     let mut map = Term::map_new(env);

//     for (key, value) in record {
//         map = map
//             .map_put(key.encode(env), encode_field(env, value))
//             .expect("failed to encode map entry");
//     }

//     map
// }


rustler::init!("Elixir.DarnDmap.Native");
