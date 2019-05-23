import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.Context;

using haxe.macro.PositionTools;


class Extern {

    /** Adds a private internal inline static variable called __touch,
        which sets the value to the current time so that builds are always
        updated by the code, and native changes are dragged in automatically (except for header only changes) */
    macro public static function touch() : Array<Field> {

        var _fields = Context.getBuildFields();

        _fields.push({
            name: '__touch', pos: Context.currentPos(),
            doc: null, meta: [], access: [APrivate, AStatic, AInline],
            kind: FVar(macro : String, macro $v{ Std.string(Date.now().getTime()) }),
        });

        return _fields;

    } //touch

    macro public static function xml():Array<Field> {
        var pos =  Context.currentPos();
        var pos_info = pos.getInfos();
        var class_ = Context.getLocalClass();

        var project_root_path = Path.directory(pos_info.file);
        if (!Path.isAbsolute(project_root_path)) {
            project_root_path = Path.join([Sys.getCwd(), project_root_path]);
        }
        project_root_path = Path.normalize(project_root_path);

        var project_root_path_var = 'PROJECT_ROOT_PATH';
        var project_root = '<set name="$project_root_path_var" value="$project_root_path"/>';

        var import_ = '<include name="$project_root_path/extern.xml" />';
        class_.get().meta.add(":buildXml", [{ expr:EConst( CString( '$project_root\n$import_' ) ), pos:pos }], pos );

        return Context.getBuildFields();

    } //xml

}

