open StlLogic
open Graph
open Model
open StlConvert
open Interface

(** Spazio **)
(* punti *)
(* grafo *)
let sgdomain = MySpaceGraph.empty
let sgdomain = MySpaceGraph.add_node "ls1" sgdomain
let sgdomain = MySpaceGraph.add_node "ls2" sgdomain
let sgdomain = MySpaceGraph.add_node "ls3" sgdomain
let sgdomain = MySpaceGraph.add_node "rs1" sgdomain
let sgdomain = MySpaceGraph.add_node "rs2" sgdomain
let sgdomain = MySpaceGraph.add_node "rs3" sgdomain
let sgdomain = MySpaceGraph.add_node "b1" sgdomain
let sgdomain = MySpaceGraph.add_node "b2" sgdomain
let sgdomain = MySpaceGraph.add_node "b3" sgdomain
let sgdomain = MySpaceGraph.add_edge "ls1" "ls2" sgdomain
let sgdomain = MySpaceGraph.add_edge "ls2" "ls3" sgdomain
let sgdomain = MySpaceGraph.add_edge "ls1" "b1" sgdomain
let sgdomain = MySpaceGraph.add_edge "ls2" "b1" sgdomain
let sgdomain = MySpaceGraph.add_edge "ls3" "b1" sgdomain
let sgdomain = MySpaceGraph.add_edge "b1" "b2" sgdomain
let sgdomain = MySpaceGraph.add_edge "b2" "b3" sgdomain
let sgdomain = MySpaceGraph.add_edge "b3" "rs1" sgdomain
let sgdomain = MySpaceGraph.add_edge "b3" "rs2" sgdomain
let sgdomain = MySpaceGraph.add_edge "b3" "rs3" sgdomain
let sgdomain = MySpaceGraph.add_edge "rs1" "rs2" sgdomain
let sgdomain = MySpaceGraph.add_edge "rs2" "rs3" sgdomain
let sgdomain = MySpaceGraph.standard_closure sgdomain

let space_bridge = MySpaceGraph.empty
let space_bridge = MySpaceGraph.add_node "b1" space_bridge
let space_bridge = MySpaceGraph.add_node "b2" space_bridge
let space_bridge = MySpaceGraph.add_node "b3" space_bridge

let space_side = MySpaceGraph.empty
let space_side = MySpaceGraph.add_node "ls1" space_side
let space_side = MySpaceGraph.add_node "ls2" space_side
let space_side = MySpaceGraph.add_node "ls3" space_side
let space_side = MySpaceGraph.add_node "rs1" space_side
let space_side = MySpaceGraph.add_node "rs2" space_side
let space_side = MySpaceGraph.add_node "rs3" space_side
(* spazio *)


(** Tempo **)
(* punti *)
(* grafo *)
let tgdomain = MyTimeGraph.empty
let tgdomain = MyTimeGraph.add_node "nothing" tgdomain
let tgdomain = MyTimeGraph.add_node "cls2" tgdomain
let tgdomain = MyTimeGraph.add_node "cb1" tgdomain
let tgdomain = MyTimeGraph.add_node "cb2" tgdomain
let tgdomain = MyTimeGraph.add_node "cb3" tgdomain
let tgdomain = MyTimeGraph.add_node "crs2" tgdomain
let tgdomain = MyTimeGraph.add_node "fb2" tgdomain
let tgdomain = MyTimeGraph.add_node "fb123" tgdomain
let tgdomain = MyTimeGraph.add_arc "nothing" "nothing" tgdomain
let tgdomain = MyTimeGraph.add_arc "nothing" "cls2" tgdomain
let tgdomain = MyTimeGraph.add_arc "cls2" "cb1" tgdomain
let tgdomain = MyTimeGraph.add_arc "cb1" "cb2" tgdomain
let tgdomain = MyTimeGraph.add_arc "cb2" "cb3" tgdomain
let tgdomain = MyTimeGraph.add_arc "cb3" "crs2" tgdomain
let tgdomain = MyTimeGraph.add_arc "crs2" "nothing" tgdomain
let tgdomain = MyTimeGraph.add_edge "nothing" "fb2" tgdomain
let tgdomain = MyTimeGraph.add_edge "fb2" "fb123" tgdomain
(* tempo *)


(** Modello **)
let cp = fun (s,t) -> (s,t)
let st = MyModel.st_make sgdomain tgdomain

let st_empty = MyModel.st_empty
let bridge = MyModel.st_cartesian_product (MyModel.space_domain space_bridge) (MyModel.time_domain tgdomain)
let side = MyModel.st_cartesian_product (MyModel.space_domain space_side) (MyModel.time_domain tgdomain)
let camion = st_empty
let camion = MyModel.st_add (MyModel.st_make_point "ls2" "cls2") camion
let camion = MyModel.st_add (MyModel.st_make_point "b1" "cb1") camion
let camion = MyModel.st_add (MyModel.st_make_point "b2" "cb2") camion
let camion = MyModel.st_add (MyModel.st_make_point "b3" "cb3") camion
let camion = MyModel.st_add (MyModel.st_make_point "rs2" "crs2") camion
let fload = st_empty
let fload = MyModel.st_add (MyModel.st_make_point "b2" "fb2") fload
let fload = MyModel.st_add (MyModel.st_make_point "b1" "fb123") fload
let fload = MyModel.st_add (MyModel.st_make_point "b2" "fb123") fload
let fload = MyModel.st_add (MyModel.st_make_point "b3" "fb123") fload
let env = MyModel.empty_env
let env = MyModel.bind "bridge" bridge env
let env = MyModel.bind "side" side env
let env = MyModel.bind "camion" camion env
let env = MyModel.bind "fload" fload env



(** Logica **)
(* ambiente *)
let fsyntax_env = MyLogic.empty_env
type mutable_env = { mutable env : MyModel.st_pointset MyLogic.parametric_fsyntax MyLogic.Env.t }
let fs_env = { env = fsyntax_env }